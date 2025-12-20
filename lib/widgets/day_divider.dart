import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/design_constants.dart';

class DayDivider extends StatelessWidget {
  final String dayDate;
  final String dayIndex;
  const DayDivider({super.key, required this.dayDate, required this.dayIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0
      ), // margin from screen edges
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: DesignConstants.secondaryTextColor,
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'DAY $dayIndex - ${dayDate.toUpperCase()}',
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                textStyle: TextStyle(
                  color: DesignConstants.secondaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: DesignConstants.secondaryTextColor,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
