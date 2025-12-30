import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utsav_app/util/design_constants.dart';

class ErrorTicket extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorTicket({
    super.key, 
    required this.errorMessage, 
    required this.onRetry
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: DesignConstants.red.withAlpha(100), width: 4),
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      color: DesignConstants.primaryCardColor,
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Styled Error Icon
            Icon(
              FontAwesomeIcons.circleExclamation,
              color: DesignConstants.red,
              size: 50,
            ),
            const SizedBox(height: 20),
            Text(
              "COULD NOT LOAD TICKETS",
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoCondensed(
                color: DesignConstants.secondaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              errorMessage.replaceFirst("Exception: ", ""),
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoCondensed(
                color: DesignConstants.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            
            // Premium Retry Button
            TextButton(
              style: TextButton.styleFrom(
                // side: BorderSide(color: DesignConstants.red, width: 1.5),
                backgroundColor: DesignConstants.red,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: onRetry,
              child: Text(
                "TRY AGAIN",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}