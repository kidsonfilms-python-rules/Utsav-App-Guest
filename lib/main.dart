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
  String MAPBOX_ACCESS_TOKEN = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? 'CANT FIND';
  print("MAPBOX TOKEN: $MAPBOX_ACCESS_TOKEN");
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

  @override
  void initState() {
    super.initState();
    _currentPage = HomePage(navigateToPage: _navigateToPage);
    _pageStack.add(_currentPage);
    _navigationHistory.add(2); // HomePage corresponds to index 2
  }

  void _navigateToPage(int index, {String? markerId}) {
    HapticFeedback.lightImpact();
    Widget newPage;
    switch (index) {
      case 0:
        newPage = TicketsPage();
        break;
      case 1:
        newPage = AnnouncementsPage();
        break;
      case 2:
        newPage = HomePage(navigateToPage: _navigateToPage);
        break;
      case 3:
        newPage = SchedulePage(navigateToPage: _navigateToPage);
        break;
      case 4:
        // When navigating to MapPage, optionally pass a marker id
        newPage = MapPage(autoSelectMarkerId: markerId);

        break;
      default:
        newPage = MapPage();
        break;
    }
    setState(() {
      _selectedTab = index;
      _pageStack.add(newPage);
      _navigationHistory.add(index);
      _currentPage = newPage;
    });
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
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: DesignConstants.backgroundColor,
        bottomNavigationBar: GNav(
          key: const PageStorageKey('bottom_nav_bar'),
          selectedIndex: _selectedTab,
          haptic: true,
          color: const Color.fromARGB(255, 120, 120, 120),
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
