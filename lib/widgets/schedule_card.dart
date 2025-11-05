import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:utsav_app/widgets/snackbar.dart';
import 'package:share_plus/share_plus.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final String time;
  final String location;
  final String description;
  final bool isNow;
  final bool expanded;
  final AnimationController? animationController;
  final Function(int, {String? markerId}) navigateToPage;

  const ExpandableCard({
    super.key,
    required this.title,
    required this.time,
    required this.location,
    required this.description,
    this.isNow = false,
    this.animationController,
    required this.navigateToPage,
    this.expanded = false,
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool _isExpanded = false;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  @override
  bool get wantKeepAlive => true;

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

    setState(() {
      _isExpanded = widget.expanded;
      if (_isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  bool _isDisposed = false;

  @override
  void dispose() {
    if (!_isDisposed) {
      _expandController.dispose();
      widget.animationController?.dispose();
      _isDisposed = true;
    }
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
                        330.0; // 20.0 is the desired margin
                    return Stack(
                      clipBehavior: Clip.none, // Prevent clipping
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: DesignConstants.backgroundColor,
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
                                  color: DesignConstants.primaryTextColor,
                                ),
                                title: Text(
                                  'Subscribe to notifications',
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.primaryTextColor,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Handle edit action
                                  MainSnackbar(
                                    message:
                                        'Subscribed to event notifications!',
                                    // showNewIndicator: true
                                  ).show(context);
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.mapLocationDot,
                                  color: DesignConstants.primaryTextColor,
                                ),
                                title: Text(
                                  'Open in Map',
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.primaryTextColor,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Handle delete action
                                  Navigator.of(context).pop();
                                  widget.navigateToPage(
                                    4,
                                    markerId: widget.location,
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.share,
                                  color: DesignConstants.primaryTextColor,
                                ),
                                title: Text(
                                  'Share',
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.primaryTextColor,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  // Handle delete action
                                  Share.share(
                                    "Come with me to check out Utsav's ${widget.title} which starts at ${widget.time} at ${widget.location}!\n\nAbout Utsav's ${widget.title}: ${widget.description}",
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.solidCopy,
                                  color: DesignConstants.primaryTextColor,
                                ),
                                title: Text(
                                  'Copy details',
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.primaryTextColor,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  await Clipboard.setData(
                                    ClipboardData(
                                      text:
                                          "${widget.title} starts at ${widget.time} at ${widget.location}. About ${widget.title}: ${widget.description}",
                                    ),
                                  );
                                  // Handle delete action
                                  if (context.mounted) {
                                    MainSnackbar(
                                      message: 'Copied!',
                                      icon: Icon(
                                        FontAwesomeIcons.check,
                                        color: DesignConstants.green,
                                      ),
                                      // showNewIndicator: true
                                    ).show(context);
                                  }
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
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
                              navigateToPage: widget.navigateToPage,
                              expanded: true,
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
    super.build(context);
    return GestureDetector(
      onTap: _handleTap,
      onLongPress: () => _showOptionsModal(context),
      onDoubleTap: () {
        MainSnackbar(
          message: 'Subscribed to event notifications!',
          // showNewIndicator: true
        ).show(context);
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        color: DesignConstants.primaryCardColor,
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
                          color: DesignConstants.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BlinkingDot(
                      color: DesignConstants.green,
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
                          color: DesignConstants.primaryTextColor,
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
                        color: DesignConstants.secondaryTextColor,
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
                                color: DesignConstants.secondaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            widget.location,
                            style: GoogleFonts.getFont(
                              "Roboto Condensed",
                              textStyle: TextStyle(
                                color: DesignConstants.primaryTextColor,
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
                            color: DesignConstants.primaryTextColor,
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
    super.key,
    required this.color,
    required this.size,
    this.animation,
  });

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
