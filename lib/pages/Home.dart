import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utsav_app/pages/Settings.dart';
import 'package:utsav_app/pages/settings/profile.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int> navigateToPage;

  const HomePage({required this.navigateToPage, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            "WELCOME BACK",
            style: GoogleFonts.getFont(
              "Roboto Condensed",
              textStyle: TextStyle(
                color: DesignConstants.primaryTextColor,
                fontSize: 56,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    // padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(
                      color: DesignConstants.secondaryTextColor,
                      width: 2,
                    ),
                    iconColor: DesignConstants.primaryTextColor,
                    iconSize: 22.5,
                  ),
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (BuildContext context) => const SettingsPage(),
                        ),
                      ),
                  label: Text(
                    "SETTINGS",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      textStyle: TextStyle(
                        color: DesignConstants.primaryTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  icon: Icon(FontAwesomeIcons.gear),
                  // style: ButtonStyle(
                  //   backgroundColor: WidgetStateProperty.all(
                  //     DesignConstants.primaryCardColor,
                  //   ),
                  //   iconColor: WidgetStateProperty.all(
                  //     DesignConstants.primaryTextColor,
                  //   ),
                  //   iconSize: WidgetStateProperty.all(25),
                  // ),
                ),
                Spacer(),
                TextButton.icon(
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (BuildContext context) =>
                                  const AccountSettingsPage(),
                        ),
                      ),
                  label: Text(
                    "PROFILE",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      textStyle: TextStyle(
                        color: DesignConstants.primaryTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  icon: Icon(FontAwesomeIcons.solidCircleUser),
                  // style: ButtonStyle(
                  //   backgroundColor: WidgetStateProperty.all(
                  //     DesignConstants.primaryCardColor,
                  //   ),
                  //   iconColor: WidgetStateProperty.all(
                  //     DesignConstants.primaryTextColor,
                  //   ),
                  //   iconSize: WidgetStateProperty.all(25),
                  // ),
                  style: TextButton.styleFrom(
                    // padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(
                      color: DesignConstants.secondaryTextColor,
                      width: 2,
                    ),
                    iconColor: DesignConstants.primaryTextColor,
                    iconSize: 22.5,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => widget.navigateToPage(3),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: DesignConstants.primaryCardColor,
              margin: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(20),
                width: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "UPCOMING EVENT",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.secondaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Natok #1",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.primaryTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "7:30 PM - 9:30 PM",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.primaryTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => widget.navigateToPage(1),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: DesignConstants.primaryCardColor,
              margin: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(20),
                width: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NEW ANNOUNCEMENT",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.secondaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Dinner is currently being served.",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.primaryTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => widget.navigateToPage(0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: DesignConstants.primaryCardColor,
              margin: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(20),
                width: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TICKETS",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.secondaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "2 Adult, 2 Child",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.primaryTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
