import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/DesignConstants.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  _AccessibilityPageState createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  _AccessibilityPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DesignConstants.BACKGROUND_COLOR,
        title: Text(
          "ACCESSIBILITY",
          style: GoogleFonts.getFont(
            'Roboto Condensed',
            fontWeight: FontWeight.w200,
            textStyle: TextStyle(color: DesignConstants.TEXT_PRIMARY_COLOR),
          ),
        ),
        foregroundColor: DesignConstants.TEXT_PRIMARY_COLOR,
      ),
      backgroundColor: DesignConstants.BACKGROUND_COLOR,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    "English",
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      textStyle: TextStyle(color: DesignConstants.TEXT_PRIMARY_COLOR),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                  },
                  child: Text(
                    "CHANGE >",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "LANGUAGE",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.TEXT_SECONDARY_COLOR,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DesignConstants.TEXT_SECONDARY_COLOR,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    "Off",
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      textStyle: TextStyle(color: DesignConstants.TEXT_PRIMARY_COLOR),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                  },
                  child: Text(
                    "CHANGE >",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "CLOSED CAPTIONS",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.TEXT_SECONDARY_COLOR,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DesignConstants.TEXT_SECONDARY_COLOR,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    "Email us if you still need help.",
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      textStyle: TextStyle(color: DesignConstants.TEXT_PRIMARY_COLOR),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                  },
                  child: Text(
                    "OPEN >",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "CONTACT US",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.TEXT_SECONDARY_COLOR,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DesignConstants.TEXT_SECONDARY_COLOR,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
