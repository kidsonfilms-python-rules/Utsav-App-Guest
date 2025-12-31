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
        // side: BorderSide(color: DesignConstants.red.withAlpha(100), width: 4),
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      color: DesignConstants.backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Styled Error Icon
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: DesignConstants.red,
                shape: BoxShape.circle,
                border: Border.all(
                  color: DesignConstants.red.withValues(alpha: 0.2),
                  strokeAlign: 2,
                  width: 5,
                ),
              ),
              child: FaIcon(
                FontAwesomeIcons.triangleExclamation,
                color: Colors.black,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "COULD NOT LOAD TICKETS",
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoCondensed(
                color: DesignConstants.red,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              errorMessage.contains('SocketException')
                  ? "We couldn't reach the servers. Please check your internet connection and try again."
                  : errorMessage.replaceFirst("Exception: ", ""),
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoCondensed(
                color: DesignConstants.secondaryTextColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            
            // Premium Retry Button
            TextButton.icon(
              onPressed: onRetry,
              icon: const FaIcon(FontAwesomeIcons.arrowRotateLeft, size: 14),
              label: Text(
                "TRY AGAIN",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: DesignConstants.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}