import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Run 'flutter pub add shimmer'
import 'package:utsav_app/util/design_constants.dart';

class MediumCardSkeleton extends StatelessWidget {
  const MediumCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the app is currently in Light Mode
    final bool isLightMode = !DesignConstants.themeOptions[DesignConstants.chosenTheme].isDark;

    // Define colors based on the theme
    // Dark Mode: Uses your original white-opacity values
    // Light Mode: Uses standard grey shimmer values for visibility
    final Color shimmerBase = isLightMode 
        ? Colors.grey[200]! 
        : Colors.white.withValues(alpha: 0.05);
        
    final Color shimmerHighlight = isLightMode 
        ? const Color.fromARGB(255, 249, 249, 249)
        : Colors.white.withValues(alpha: 0.1);

    return Shimmer.fromColors(
      baseColor: shimmerBase,
      highlightColor: shimmerHighlight,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        color: DesignConstants.primaryCardColor,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Skeleton (The "NEW" bar)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Body Skeleton (The message and time)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 120,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
