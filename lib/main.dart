import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:utsav_app/pages/Announcements.dart';
import 'package:utsav_app/pages/Home.dart';
import 'package:utsav_app/pages/Schedule.dart';
import 'package:utsav_app/pages/Tickets.dart';
import 'package:utsav_app/util/DesignConstants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: DesignConstants.BACKGROUND_COLOR,
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
    // Initialize with HomePage
    _currentPage = HomePage(navigateToPage: _navigateToPage);
    _pageStack.add(_currentPage);
    _navigationHistory.add(2); // HomePage corresponds to index 2
  }

  void _navigateToPage(int index) {
    HapticFeedback.lightImpact();
    Widget newPage;

    // Determine which page to navigate to based on the index
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
        newPage = SchedulePage();
        break;
      default:
        newPage = HomePage(navigateToPage: _navigateToPage);
        break;
    }

    setState(() {
      _selectedTab = index;
      _pageStack.add(newPage); // Add new page to the stack
      _navigationHistory.add(index); // Record the navigation index
      _currentPage = newPage;
    });
  }

  Future<bool> _onWillPop() async {
    // If the stack has more than one page, pop the last page
    if (_pageStack.length > 1) {
      setState(() {
        _pageStack.removeLast(); // Remove the last page
        _navigationHistory.removeLast(); // Remove the last navigation index
        int lastIndex = _navigationHistory.last;
        _selectedTab = lastIndex; // Update the selected tab index
        _currentPage = _pageStack.last; // Set the current page to the last one
      });
      return false; // Prevent the default back button behavior
    }
    return true; // If only one page, exit the app
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: DesignConstants.BACKGROUND_COLOR,
        bottomNavigationBar: GNav(
          key: PageStorageKey('bottom_nav_bar'), // Persist the navigation bar state
          selectedIndex: _selectedTab,
          haptic: true,
          color: const Color.fromARGB(255, 120, 120, 120),
          activeColor: Colors.white,
          iconSize: 22,
          backgroundColor: DesignConstants.PRIMARY_CARD_COLOR,
          onTabChange: _navigateToPage,
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
