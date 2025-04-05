import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
          alignment: Alignment.center,
          child: AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: itemCount,
            effect: ScrollingDotsEffect(
              activeDotColor: activeIndicatorColor,
              dotColor: inactiveIndicatorColor,
              dotHeight: 10,
              dotWidth: 10,
              activeStrokeWidth: 3,
            ),
            onDotClicked: (index) => onDotTapped(index),
          ),
        );
      },
    );
  }
}
