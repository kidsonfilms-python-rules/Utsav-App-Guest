import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/DesignConstants.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final String time;
  final String location;
  final String description;
  final bool isNow;
  final AnimationController? animationController;

  const ExpandableCard({
    Key? key,
    required this.title,
    required this.time,
    required this.location,
    required this.description,
    this.isNow = false,
    this.animationController,
  }) : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );

    // Start the blinking animation if isNow is true and an external controller is not provided
    if (widget.isNow && widget.animationController == null) {
      widget.animationController?.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _expandController.dispose();
    widget.animationController?.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.lightImpact();
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        color: DesignConstants.PRIMARY_CARD_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isNow)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "NOW",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.GREEN,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BlinkingDot(
                      color: DesignConstants.GREEN,
                      size: 8.0,
                      animation: widget.animationController,
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.title,
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.TEXT_PRIMARY_COLOR,
                          fontSize: 20,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.time,
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      textStyle: TextStyle(
                        color: DesignConstants.TEXT_SECONDARY_COLOR,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizeTransition(
                sizeFactor: _expandAnimation,
                axisAlignment: -1.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "LOCATION",
                            style: GoogleFonts.getFont(
                              "Roboto Condensed",
                              textStyle: TextStyle(
                                color: DesignConstants.TEXT_SECONDARY_COLOR,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            widget.location,
                            style: GoogleFonts.getFont(
                              "Roboto Condensed",
                              textStyle: TextStyle(
                                color: DesignConstants.TEXT_PRIMARY_COLOR,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.description,
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          textStyle: TextStyle(
                            color: DesignConstants.TEXT_PRIMARY_COLOR,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlinkingDot extends StatelessWidget {
  final Color color;
  final double size;
  final AnimationController? animation;

  const BlinkingDot({
    Key? key,
    required this.color,
    required this.size,
    this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation ?? AlwaysStoppedAnimation(1.0),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
