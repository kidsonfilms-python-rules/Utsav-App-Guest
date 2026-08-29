import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utsav_app/pages/announcements.dart';
import 'package:utsav_app/pages/home.dart';
import 'package:utsav_app/pages/map.dart';
import 'package:utsav_app/pages/schedule.dart';
import 'package:utsav_app/pages/sign_in.dart';
import 'package:utsav_app/pages/tickets.dart';
import 'package:utsav_app/providers/announcement_provider.dart';
import 'package:utsav_app/providers/theme_provider.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utsav_app/widgets/connectivity_banner.dart';
import 'dart:ui' as ui;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
  // ignore: non_constant_identifier_names
  String MAPBOX_ACCESS_TOKEN = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? 'CANT FIND';
  MapboxOptions.setAccessToken(MAPBOX_ACCESS_TOKEN);

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
  if (supabaseUrl == null || supabaseAnonKey == null) {
    throw StateError(
      'SUPABASE_URL and SUPABASE_ANON_KEY must be set in .env.',
    );
  }
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  await GoogleFonts.pendingFonts([GoogleFonts.robotoCondensed()]);

  runApp(ProviderScope(child: MyApp(prefs)));
}

class MyApp extends ConsumerWidget {
  final SharedPreferences prefs;
  const MyApp(this.prefs, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? theme = prefs.getInt("THEME");
    if (theme != DesignConstants.chosenTheme && theme != null) {
      DesignConstants.chosenTheme = theme;
      DesignConstants.updateTheme();
    }

    bool isSignedIn = false;
    final currentThemeIndex = ref.watch(themeProvider);

    return MaterialApp(
      title: 'The Utsav App',
      navigatorKey: DesignConstants.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: DesignConstants.backgroundColor,
          brightness:
              DesignConstants.themeOptions[DesignConstants.chosenTheme].isDark
                  ? Brightness.dark
                  : Brightness.light,
        ),
      ),
      builder: (context, child) {
        return Scaffold(
          // Provides a base background color
          backgroundColor: DesignConstants.backgroundColor,
          body: Column(
            children: [
              const ConnectivityBanner(), // This expands/collapses
              Expanded(child: child!), // This fills the rest of the space
            ],
          ),
        );
      },
      home: !isSignedIn ? WelcomePage() : MainPage(),
    );
  }
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late Widget _currentPage;
  int _selectedTab = 2;
  final List<Widget> _pageStack = [];
  final List<int> _navigationHistory = [];
  late final Map<int, Widget> _pages;
  List<bool> _hasUpdate = [
    false,
    true,
    false,
    false,
    false,
  ]; // example: Announcements has update

  bool _showNativeAppBar = false;

  // Call this from your sub-pages to toggle the visibility
  void updateAppBarVisibility(bool visible) {
    if (_showNativeAppBar != visible) {
      setState(() {
        _showNativeAppBar = visible;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _pages = {
      0: TicketsPage(key: const PageStorageKey('ticketsPage')),
      1: AnnouncementsPage(
        key: const PageStorageKey('announcementsPage'),
        onScroll: updateAppBarVisibility,
      ),
      2: HomePage(
        navigateToPage: _navigateToPage,
        key: const PageStorageKey('homePage'),
      ),
      3: SchedulePage(
        navigateToPage: _navigateToPage,
        key: const PageStorageKey('schedulePage'),
      ),
      4: MapPage(
        key: const PageStorageKey('mapPage'),
        autoSelectMarkerId: null,
      ),
    };
    _selectedTab = 2;
    _currentPage = _pages[_selectedTab]!;
    _pageStack.add(_currentPage);
    _navigationHistory.add(_selectedTab); // HomePage corresponds to index 2
  }

  bool customMapPage = false;

  void _navigateToPage(int index, {String? markerId}) {
    HapticFeedback.lightImpact();

    Widget newPage = _pages[index]!;

    // If MapPage and markerId is provided, create a new instance with markerId
    if (index == 4 && markerId != null) {
      newPage = MapPage(
        autoSelectMarkerId: markerId,
        key: const PageStorageKey('mapPage'),
      );
      _pages[4] = newPage;
      customMapPage = true;
    } else if (index == 4 && markerId == null && customMapPage) {
      newPage = MapPage(
        autoSelectMarkerId: null,
        key: const PageStorageKey('mapPage'),
      );
      _pages[4] = newPage;
      customMapPage = false;
    }

    // Only add to stack if navigating to a new page (avoid duplicates in a row)
    if (_currentPage != newPage) {
      _pageStack.add(newPage);
      _navigationHistory.add(index);
      setState(() {
        updateAppBarVisibility(false);
        _selectedTab = index;
        _currentPage = newPage;
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (_pageStack.length > 1) {
      setState(() {
        _pageStack.removeLast();
        _navigationHistory.removeLast();
        int lastIndex = _navigationHistory.last;
        _selectedTab = lastIndex;
        _currentPage = _pageStack.last;
      });
      return false;
    }
    return true; // exit app
  }

  Widget _buildIcon(
    IconData icon, {
    bool active = false,
    bool showDot = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          icon,
          color:
              active
                  ? DesignConstants.primaryTextColor
                  : const Color.fromARGB(255, 114, 114, 117),
          size: 22,
        ),
        if (showDot)
          Positioned(
            right: -9,
            top: -9,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: DesignConstants.green,
                shape: BoxShape.circle,
                border: BoxBorder.all(
                  color: DesignConstants.primaryCardColor,
                  width: 4,
                  // strokeAlign: 1
                ),
              ),
            ),
          ),
      ],
    );
  }

  // Helpers for dynamic content
  String _getTabTitle(int index) {
    switch (index) {
      case 1:
        return "ANNOUNCEMENTS";
      case 2:
        return "HOME";
      case 3:
        return "SCHEDULE";
      default:
        return "";
    }
  }

  List<Widget>? _getAppBarActions(int index) {
    if (index == 1 && _showNativeAppBar) {
      return [
        IconButton(
          icon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: DesignConstants.primaryTextColor,
          ),
          onPressed: () {},
        ),
      ];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // 1. Watch the announcements provider
    final announcementsAsync = ref.watch(announcementsProvider);
    final announcements = announcementsAsync.value ?? [];
    final hasUnreadAnnouncements = announcements.any((a) => !a.isRead);
    _hasUpdate[1] = hasUnreadAnnouncements;

    return PopScope(
      // onWillPop: _onWillPop,
      canPop: _pageStack.length <= 1, // Allow system pop only if no history
      onPopInvokedWithResult: (didPop, result) async {
        // Only handle pop manually if Flutter didn’t handle it
        if (!didPop) {
          final shouldPop = await _onWillPop();
          if (shouldPop && context.mounted) {
            // If at root, exit app
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: DesignConstants.backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: ui.Size.fromHeight(kToolbarHeight),
          child: AnimatedOpacity(
            opacity: _showNativeAppBar ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child:
                _selectedTab != 0 || _selectedTab != 4
                    ? AppBar(
                      // If not showing, we disable hits so you can click "through" it to the content below
                      automaticallyImplyLeading: false,
                      backgroundColor: DesignConstants.backgroundColor,
                      elevation: 4, // Adds a nice shadow over the content
                      centerTitle: true,
                      title: Text(
                        _getTabTitle(_selectedTab),
                        style: GoogleFonts.robotoCondensed(
                          textStyle: TextStyle(
                            color: DesignConstants.primaryTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      actions: _getAppBarActions(_selectedTab),
                    )
                    : null,
          ),
        ),
        bottomNavigationBar: GNav(
          key: const PageStorageKey('bottom_nav_bar'),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          selectedIndex: _selectedTab,
          haptic: true,
          color: const Color.fromARGB(255, 114, 114, 117),
          // color: Colors.white,
          activeColor: Colors.white,
          iconSize: 22,
          backgroundColor: DesignConstants.primaryCardColor,
          onTabChange: (index) {
            _navigateToPage(index);
          },
          tabs: [
            GButton(
              icon: FontAwesomeIcons.ticket,
              leading: _buildIcon(
                _selectedTab == 0
                    ? FontAwesomeIcons.ticketSimple
                    : FontAwesomeIcons.ticket,
                active: _selectedTab == 0,
                showDot: _hasUpdate[0],
              ),
            ),
            GButton(
              icon: FontAwesomeIcons.bullhorn,
              leading: _buildIcon(
                FontAwesomeIcons.bullhorn,
                active: _selectedTab == 1,
                showDot: _hasUpdate[1],
              ),
            ),
            GButton(
              icon: FontAwesomeIcons.house,
              leading: _buildIcon(
                _selectedTab == 2
                    ? FontAwesomeIcons.solidHouse
                    : FontAwesomeIcons.house,
                active: _selectedTab == 2,
                showDot: _hasUpdate[2],
              ),
            ),
            GButton(
              icon: FontAwesomeIcons.house,
              leading: _buildIcon(
                _selectedTab == 3
                    ? FontAwesomeIcons.solidClock
                    : FontAwesomeIcons.clock,
                active: _selectedTab == 3,
                showDot: _hasUpdate[3],
              ),
            ),
            GButton(
              icon: FontAwesomeIcons.house,
              leading: _buildIcon(
                _selectedTab == 4
                    ? FontAwesomeIcons.solidCompass
                    : FontAwesomeIcons.compass,
                active: _selectedTab == 4,
                showDot: _hasUpdate[4],
              ),
            ),
          ],
        ),

        body: _currentPage,
      ),
    );
  }
}
