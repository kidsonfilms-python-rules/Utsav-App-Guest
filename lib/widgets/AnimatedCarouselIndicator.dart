import 'package:flutter/material.dart';
import 'package:utsav_app/util/DesignConstants.dart';

class AnimatedCarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int activeIndex;
  final Color activeIndicatorColor;
  final Color inactiveIndicatorColor;
  final ValueChanged<int> onDotTapped;

  const AnimatedCarouselIndicator({
    Key? key,
    required this.itemCount,
    required this.activeIndex,
    required this.activeIndicatorColor,
    required this.inactiveIndicatorColor,
    required this.onDotTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([ValueNotifier<int>(activeIndex)]),
      builder: (context, child) {
        return Container(
          width: 150,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color:
                DesignConstants
                    .PRIMARY_CARD_COLOR, // Replace with your primary card color if needed
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(itemCount, (index) {
              double width = 10.0;
              double height = 10.0;
              Color color = inactiveIndicatorColor;

              if (index == activeIndex) {
                width = 20.0; // Active indicator width
                height = 10.0; // Active indicator height (elongated)
                color = activeIndicatorColor;
              }

              return GestureDetector(
                onTap: () => onDotTapped(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
