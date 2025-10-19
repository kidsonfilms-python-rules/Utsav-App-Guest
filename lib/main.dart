import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utsav_app/pages/announcements.dart';
import 'package:utsav_app/pages/home.dart';
import 'package:utsav_app/pages/map.dart';
import 'package:utsav_app/pages/schedule.dart';
import 'package:utsav_app/pages/tickets.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp(this.prefs, {super.key});

  @override
  Widget build(BuildContext context) {
    int? theme = prefs.getInt("THEME");
    if (theme != DesignConstants.chosenTheme && theme != null) {
      DesignConstants.chosenTheme = theme;
      DesignConstants.updateTheme();
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: DesignConstants.backgroundColor,
        ),
      ),
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Widget _currentPage;
  int _selectedTab = 2;
  final List<Widget> _pageStack = [];
  final List<int> _navigationHistory = [];
  late final Map<int, Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = {
    0: TicketsPage(key: const PageStorageKey('ticketsPage')),
    1: AnnouncementsPage(key: const PageStorageKey('announcementsPage')),
    2: HomePage(navigateToPage: _navigateToPage, key: const PageStorageKey('homePage')),
    3: SchedulePage(navigateToPage: _navigateToPage, key: const PageStorageKey('schedulePage')),
    4: MapPage(key: const PageStorageKey('mapPage'), autoSelectMarkerId: null),
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
    newPage = MapPage(autoSelectMarkerId: markerId, key: const PageStorageKey('mapPage'));
    _pages[4] = newPage;
    customMapPage = true;
  } else if (index == 4 && markerId == null && customMapPage) {
    newPage = MapPage(autoSelectMarkerId: null, key: const PageStorageKey('mapPage'));
    _pages[4] = newPage;
    customMapPage = false;
  }

  // Only add to stack if navigating to a new page (avoid duplicates in a row)
  if (_currentPage != newPage) {
    _pageStack.add(newPage);
    _navigationHistory.add(index);
    setState(() {
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

  @override
  Widget build(BuildContext context) {
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
        bottomNavigationBar: GNav(
          key: const PageStorageKey('bottom_nav_bar'),
          padding: EdgeInsets.fromLTRB(24, 12, 24, 24),
          selectedIndex: _selectedTab,
          haptic: true,
          color: const Color.fromARGB(255, 114, 114, 117),
          activeColor: Colors.white,
          iconSize: 22,
          backgroundColor: DesignConstants.primaryCardColor,
          onTabChange: (index) {
            // For example, if you want to auto-select marker1 when MapPage is selected,
            // pass the marker id:

            _navigateToPage(index);
          },
          tabs: const [
            GButton(icon: FontAwesomeIcons.ticket),
            GButton(icon: FontAwesomeIcons.bullhorn),
            GButton(icon: FontAwesomeIcons.house),
            GButton(icon: FontAwesomeIcons.clock),
            GButton(icon: FontAwesomeIcons.compass),
          ],
        ),
        body: _currentPage,
      ),
    );
  }
}
