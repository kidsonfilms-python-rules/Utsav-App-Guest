import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:utsav_app/util/design_constants.dart';

class TicketSkeleton extends StatelessWidget {
  const TicketSkeleton({super.key});

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

    final Color barcodeBg = isLightMode
        ? Colors.grey[200]!
        : Colors.white12;

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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Header: TICKET X and Blinking Dot equivalent
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 80, height: 16, decoration: _bone()),
                  const SizedBox(width: 15),
                  Container(width: 8, height: 8, decoration: _bone(circular: true)),
                ],
              ),
              
              // Barcode Box
              Container(
                height: 80, // Approximate barcode height
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: barcodeBg,
                ),
                margin: const EdgeInsets.all(20),
              ),

              // Name Section
              _skeletonSection(context, labelWidth: 40, contentWidth: 200, contentHeight: 40),
              const SizedBox(height: 20),

              // Type and Total Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _columnBone(labelWidth: 70, contentWidth: 50),
                    const SizedBox(width: 25),
                    _columnBone(labelWidth: 80, contentWidth: 40),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Venue
              _skeletonSection(context, labelWidth: 50, contentWidth: 150),
              const SizedBox(height: 20),

              // Venue Instructions
              _skeletonSection(context, labelWidth: 120, contentWidth: double.infinity, lines: 2),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _skeletonSection(BuildContext context, {required double labelWidth, required double contentWidth, double contentHeight = 16, int lines = 1}) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: labelWidth, height: 12, decoration: _bone()),
          const SizedBox(height: 8),
          for (int i = 0; i < lines; i++) ...[
             Container(width: contentWidth, height: contentHeight, decoration: _bone()),
             if (i < lines - 1) const SizedBox(height: 4),
          ]
        ],
      ),
    );
  }

  Widget _columnBone({required double labelWidth, required double contentWidth}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: labelWidth, height: 12, decoration: _bone()),
        const SizedBox(height: 8),
        Container(width: contentWidth, height: 16, decoration: _bone()),
      ],
    );
  }

  BoxDecoration _bone({bool circular = false}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(circular ? 50 : 6),
    );
  }
}