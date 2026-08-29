import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:utsav_app/providers/schedule_provider.dart';

class NoScheduleWidget extends ConsumerWidget {
  const NoScheduleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLightMode =
        !DesignConstants.themeOptions[DesignConstants.chosenTheme].isDark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Icon with subtle background
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color:
                    isLightMode
                        ? Colors.grey[200]
                        : DesignConstants.primaryCardColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: DesignConstants.secondaryTextColor.withValues(
                    alpha: 0.1,
                  ),
                  width: 2,
                ),
              ),
              child: FaIcon(
                FontAwesomeIcons.calendarDay,
                color: DesignConstants.secondaryTextColor.withValues(
                  alpha: 0.5,
                ),
                size: 40,
              ),
            ),
            const SizedBox(height: 24),

            // Primary Message
            Text(
              "NO SCHEDULE AVAILABLE",
              style: GoogleFonts.robotoCondensed(
                color: DesignConstants.primaryTextColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Secondary Description
            Text(
              "Check back later for what's planned. We're working hard to bring you an exciting schedule of events!",
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoCondensed(
                color: DesignConstants.secondaryTextColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            // Functional Refresh Button
            OutlinedButton.icon(
              onPressed: () {
                // This triggers the refresh method in your provider
                ref.read(eventsProvider.notifier).refresh();
              },
              icon: const FaIcon(FontAwesomeIcons.rotateRight, size: 14),
              label: Text(
                "REFRESH",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: DesignConstants.primaryTextColor,
                side: BorderSide(
                  color: DesignConstants.secondaryTextColor.withValues(
                    alpha: 0.3,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
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

class ErrorScheduleWidget extends ConsumerWidget {
  final String errorMessage;

  const ErrorScheduleWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Error Icon
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
            const SizedBox(height: 24),

            // Error Header
            Text(
              "COULD NOT LOAD SCHEDULE",
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoCondensed(
                color: DesignConstants.red,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Detailed Error Message
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

            // Retry Button
            TextButton.icon(
              onPressed: () => ref.read(eventsProvider.notifier).refresh(),
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
