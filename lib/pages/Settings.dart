import 'package:flutter/material.dart';
import 'package:utsav_app/util/DesignConstants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: DesignConstants.BACKGROUND_COLOR,
        ),
      ),
      home: const SettingsPage(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConstants.BACKGROUND_COLOR,
      
      body: _currentPage,
    );
  }
}
