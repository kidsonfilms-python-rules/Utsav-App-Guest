import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/DesignConstants.dart';

class MainSnackbar {
  final String message;
  final bool showNewIndicator;
  final Icon? icon;

  MainSnackbar({
    required this.message,
    this.showNewIndicator = false,
    this.icon,
  });

  void show(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    if (overlayState == null) return;

    late OverlayEntry overlayEntry;
    late AnimationController controller;
    late Animation<double> widthAnimation;
    late Animation<double> heightAnimation;
    late Animation<BorderRadius?> borderRadiusAnimation;
    late Animation<double> topPositionAnimation;
    late Animation<double> textOpacityAnimation;

    double targetWidth = MediaQuery.of(context).size.width - 40.0;

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: Navigator.of(context),
    );

    // Top position animation: move from above the screen to the target position
    topPositionAnimation = Tween<double>(
      begin: -100.0, // Start off-screen
      end: MediaQuery.of(context).padding.top + 50.0,
    ).animate(controller);

    // Width and height animations: start as a circle, then expand
    widthAnimation = TweenSequence([
      TweenSequenceItem(
        tween: ConstantTween(80.0),
        weight: 4.55,
      ), // Circle phase
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 80.0,
          end: targetWidth,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 5.05, // Expansion phase
      ),
    ]).animate(controller);

    heightAnimation = TweenSequence([
      TweenSequenceItem(
        tween: ConstantTween(80.0),
        weight: 0.25,
      ), // Circle phase
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 80.0,
          end: 80.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.75, // Expansion phase
      ),
    ]).animate(controller);

    // Border radius animation: adjust dynamically based on width
    borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(40.0),
      end: BorderRadius.circular(40.0),
    ).animate(controller);

    // Text opacity: 0 until 25% of the animation, then fades in
    textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.25, 1.0, curve: Curves.easeIn),
      ),
    );

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            double currentWidth = widthAnimation.value;
            double currentHeight = heightAnimation.value;
            double left =
                (MediaQuery.of(context).size.width - currentWidth) / 2;
            return Positioned(
              top: topPositionAnimation.value,
              left: left,
              child: Material(
                color: Colors.transparent,
                child: CustomPaint(
                  painter: GradientBorderPainter(),
                  child: Container(
                    width: currentWidth,
                    height: currentHeight,
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.0,
                      vertical: 0.0,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          DesignConstants.PRIMARY_CARD_COLOR,
                          DesignConstants.PRIMARY_CARD_COLOR_LIGHT,
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Opacity(
                      opacity: textOpacityAnimation.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            icon!,
                            SizedBox(
                              width: 8.0,
                            ), // Small gap between icon and text
                          ],
                          Flexible(
                            child: Text(
                              message,
                              style: GoogleFonts.getFont(
                                "Roboto Condensed",
                                textStyle: TextStyle(
                                  color: DesignConstants.TEXT_PRIMARY_COLOR,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              textAlign: TextAlign.center,
                              overflow:
                                  TextOverflow
                                      .ellipsis, // Ensure overflow is clipped
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    HapticFeedback.vibrate();
    overlayState.insert(overlayEntry);
    controller.forward();

    // Dismiss snackbar after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      controller.reverse().then((_) => overlayEntry.remove());
    });
  }
}

class GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint =
        Paint()
          ..shader = LinearGradient(
            colors: [DesignConstants.GREEN, DesignConstants.DARK_GREEN],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.75, 1.0],
          ).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 14.0;

    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(40.0));
    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
