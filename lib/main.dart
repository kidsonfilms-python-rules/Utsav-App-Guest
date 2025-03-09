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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // colorScheme: ColorScheme.fromSeed(seedColor: DesignConstants().BACKGROUND_COLOR),
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
  // Initialize _currentPage with a placeholder widget
  Widget _currentPage = Container(); // Placeholder until the page is set

  int _selectedTab = 2;

  @override
  void initState() {
    super.initState();
    // After the state is initialized, assign the actual HomePage
    _currentPage = HomePage(navigateToPage: _navigateToPage);
  }

  void _navigateToPage(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      if (index == 0) {
        _currentPage = TicketsPage();
      } else if (index == 1) {
        _currentPage = AnnouncementsPage();
      } else if (index == 2) {
        _currentPage = HomePage(navigateToPage: _navigateToPage);
      } else if (index == 3) {
        _currentPage = SchedulePage();
      }
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConstants.BACKGROUND_COLOR,
      extendBody: false,
      // appBar: AppBar(
      //   backgroundColor: DesignConstants.BACKGROUND_COLOR,
      //   title: Text(widget.title, style: TextStyle(color: DesignConstants.TEXT_PRIMARY_COLOR),),
      // ),
      bottomNavigationBar: GNav(
        selectedIndex: _selectedTab,
        // rippleColor: Colors.grey, // tab button ripple color when pressed
        // hoverColor: Colors.grey, // tab button hover color
        haptic: true, // haptic feedback
        // tabBorderRadius: 15,
        // tabActiveBorder: Border.all(
        //   color: Colors.black,
        //   width: 1,
        // ), // tab button border
        // tabBorder: Border.all(
        //   color: Colors.grey,
        //   width: 1,
        // ), // tab button border
        // tabShadow: [
        //   BoxShadow(color: Colors.grey.withValues(alpha: 0.5), blurRadius: 8),
        // ], // tab button shadow
        // curve: Curves.easeOutExpo, // tab animation curves
        // duration: Duration(milliseconds: 900), // tab animation duration
        // gap: 8, // the tab button gap between icon and text
        color: const Color.fromARGB(
          255,
          120,
          120,
          120,
        ), // unselected icon color
        activeColor: Colors.white,
        // activeColor: Colors.purple, // selected icon and text color
        iconSize: 22, // tab button icon size
        // tabBackgroundColor: Colors.deepOrange,
        backgroundColor: DesignConstants.PRIMARY_CARD_COLOR,
        //   alpha: 0.1,
        // ), // selected tab background color
        // tabMargin: EdgeInsets.all(10),
        // padding: EdgeInsets.symmetric(
        //   horizontal: 10,
        //   vertical: 10,
        // ), // navigation bar padding
        onTabChange:
            (index) => {
              if (index == 0)
                {
                  setState(() {
                    _currentPage = TicketsPage();
                  }),
                }
              else if (index == 1)
                {
                  setState(() {
                    _currentPage = AnnouncementsPage();
                  }),
                }
              else if (index == 2)
                {
                  setState(() {
                    _currentPage = HomePage(navigateToPage: _navigateToPage);
                  }),
                }
              else if (index == 3)
                {
                  setState(() {
                    _currentPage = SchedulePage();
                  }),
                },
            },
        tabs: [
          GButton(icon: FontAwesomeIcons.ticket),
          GButton(icon: FontAwesomeIcons.bullhorn),
          GButton(icon: FontAwesomeIcons.house),
          GButton(icon: FontAwesomeIcons.clock),
          GButton(icon: FontAwesomeIcons.compass),
        ],
      ),
      body: _currentPage,
    );
  }
}
