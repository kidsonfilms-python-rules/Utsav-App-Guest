import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/DesignConstants.dart';
import 'package:utsav_app/widgets/Snackbar.dart';

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

  void _showOptionsModal(BuildContext context) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none, // Prevent clipping
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(color: Colors.black54),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.8,
              builder: (
                BuildContext context,
                ScrollController scrollController,
              ) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    // double sheetHeight = constraints.maxHeight;
                    double sheetHeight =
                        MediaQuery.sizeOf(context).height * 0.25;
                    double cardHeight = 80.0; // Adjust as needed
                    double topPosition =
                        sheetHeight -
                        cardHeight -
                        230.0; // 20.0 is the desired margin
                    return Stack(
                      clipBehavior: Clip.none, // Prevent clipping
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: DesignConstants.BACKGROUND_COLOR,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          width: MediaQuery.sizeOf(context).width * 0.95,
                          margin: EdgeInsets.fromLTRB(
                            MediaQuery.sizeOf(context).width * 0.025,
                            0,
                            MediaQuery.sizeOf(context).width * 0.025,
                            0,
                          ),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              SizedBox(
                                height: 20,
                              ), // Space for the floating card
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.solidBell,
                                  color: DesignConstants.TEXT_PRIMARY_COLOR,
                                ),
                                title: Text(
                                  'Subscribe to notifications',
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Handle edit action
                                  MainSnackbar(
                                    message: 'Subscribed to event notifications!',
                                    // showNewIndicator: true
                                  ).show(context);
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.mapLocationDot,
                                  color: DesignConstants.TEXT_PRIMARY_COLOR,
                                ),
                                title: Text(
                                  'Open in Map',
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Handle delete action
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.share,
                                  color: DesignConstants.TEXT_PRIMARY_COLOR,
                                ),
                                title: Text(
                                  'Share',
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Handle delete action
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.solidCopy,
                                  color: DesignConstants.TEXT_PRIMARY_COLOR,
                                ),
                                title: Text(
                                  'Copy details',
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Handle delete action
                                  MainSnackbar(
                                    message: 'Copied!',
                                    icon: Icon(FontAwesomeIcons.check, color: DesignConstants.GREEN,)
                                    // showNewIndicator: true
                                  ).show(context);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: topPosition,
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.01,
                          child: Material(
                            color: Colors.transparent,
                            elevation: 8.0,
                            borderRadius: BorderRadius.circular(25.0),
                            child: ExpandableCard(
                              title: widget.title,
                              time: widget.time,
                              location: widget.location,
                              description: widget.description,
                              isNow: widget.isNow,
                              animationController: widget.animationController,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onLongPress: () => _showOptionsModal(context),
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
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
