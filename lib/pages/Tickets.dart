import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:utsav_app/widgets/animated_carousel_indicator.dart';
import 'package:utsav_app/widgets/blinking_dot.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage>
    with SingleTickerProviderStateMixin {
  final CarouselSliderController controller = CarouselSliderController();
  var _activeTicketView = 0;
  late final AnimationController _animation;
  final PageController _pageController = PageController();
  bool _showOptionsText = false;

  void _onDotTapped(int index) {
    HapticFeedback.selectionClick();
    controller.animateToPage(index);
  }

  final String address = "6826 Hazel Ave, Orangevale, CA 95662";
  Future<void> _openInDefaultMap() async {
    final encoded = Uri.encodeComponent(address);

    // Universal map URL pattern
    final Uri uri = Uri.parse(
      Uri.base.toString().contains("ios")
          ? "http://maps.apple.com/?q=$encoded"
          : "geo:0,0?q=$encoded",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback to Google Maps web
      final fallback = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$encoded",
      );
      await launchUrl(fallback, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Show "Options" text briefly after opening
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _showOptionsText = true);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _showOptionsText = false);
        });
      }
    });
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapAppName = Platform.isIOS ? "Apple Maps" : "Google Maps";

    return PageView(
      scrollDirection: Axis.vertical,
      onPageChanged: (p) {
        HapticFeedback.lightImpact();
      },
      controller: _pageController,
      children: [
        Column(
          children: [
            SizedBox(height: 50, width: MediaQuery.sizeOf(context).width),
            Text(
              "TICKETS",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                textStyle: TextStyle(
                  color: DesignConstants.primaryTextColor,
                  fontSize: 30,
                  fontStyle: FontStyle.normal,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height - 225,
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                  autoPlay: false,
                  initialPage: 0,
                  scrollDirection: Axis.horizontal,
                  animateToClosest: true,
                  height: MediaQuery.sizeOf(context).height - 150,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _activeTicketView = index;
                    });
                  },
                ),
                carouselController: controller,
                items: List<Widget>.generate(4, (int index) {
                  return ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    child: GestureDetector(
                      onLongPress: () => {HapticFeedback.heavyImpact()},
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        color: DesignConstants.primaryCardColor,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 15 + 8),
                                  Text(
                                    "TICKET ${index + 1}",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      textStyle: TextStyle(
                                        color:
                                            DesignConstants.secondaryTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  BlinkingDot(
                                    color: DesignConstants.orange,
                                    size: 8.0,
                                    animation: _animation,
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.all(20),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: BarcodeWidget(
                                  barcode: Barcode.pdf417(),
                                  data: 'UTSAV-053467-082026-0${index + 1}',
                                  errorBuilder:
                                      (context, error) =>
                                          Center(child: Text(error)),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width - 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "NAME",
                                      style: GoogleFonts.getFont(
                                        "Roboto Condensed",
                                        textStyle: TextStyle(
                                          color:
                                              DesignConstants
                                                  .secondaryTextColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "JOHN SMITH",
                                      style: GoogleFonts.getFont(
                                        "Roboto Condensed",
                                        textStyle: TextStyle(
                                          color:
                                              DesignConstants.primaryTextColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width - 100,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 25,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "TICKET TYPE",
                                          style: GoogleFonts.getFont(
                                            "Roboto Condensed",
                                            textStyle: TextStyle(
                                              color:
                                                  DesignConstants
                                                      .secondaryTextColor,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "BASIC",
                                          style: GoogleFonts.getFont(
                                            "Roboto Condensed",
                                            textStyle: TextStyle(
                                              color:
                                                  DesignConstants
                                                      .primaryTextColor,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "TOTAL TICKETS",
                                          style: GoogleFonts.getFont(
                                            "Roboto Condensed",
                                            textStyle: TextStyle(
                                              color:
                                                  DesignConstants
                                                      .secondaryTextColor,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${index + 1}/4",
                                          style: GoogleFonts.getFont(
                                            "Roboto Condensed",
                                            textStyle: TextStyle(
                                              color:
                                                  DesignConstants
                                                      .primaryTextColor,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width - 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "VENUE",
                                      style: GoogleFonts.getFont(
                                        "Roboto Condensed",
                                        textStyle: TextStyle(
                                          color:
                                              DesignConstants
                                                  .secondaryTextColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "GREAT VENUE",
                                      style: GoogleFonts.getFont(
                                        "Roboto Condensed",
                                        textStyle: TextStyle(
                                          color:
                                              DesignConstants.primaryTextColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width - 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "VENUE INSTRUCTIONS",
                                      style: GoogleFonts.getFont(
                                        "Roboto Condensed",
                                        textStyle: TextStyle(
                                          color:
                                              DesignConstants
                                                  .secondaryTextColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Park in the Guest parking lot and some other instructions",
                                      style: GoogleFonts.getFont(
                                        "Roboto Condensed",
                                        textStyle: TextStyle(
                                          color:
                                              DesignConstants.primaryTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 40),
                AnimatedCarouselIndicator(
                  itemCount: 4,
                  activeIndex: _activeTicketView,
                  activeIndicatorColor: DesignConstants.primaryTextColor,
                  inactiveIndicatorColor: DesignConstants.secondaryTextColor,
                  onDotTapped: _onDotTapped,
                ),
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    _showOptionsText ? 30 : 25,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: _showOptionsText ? 100 : 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        _showOptionsText ? 30 : 25,
                      ),
                      border: Border.all(
                        color: DesignConstants.secondaryTextColor,
                        width: 0.5,
                      ),
                      color: Colors.transparent,
                    ),
                    clipBehavior: Clip.hardEdge, // ✅ Extra safety
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            _showOptionsText ? 30 : 25,
                          ),
                        ),
                        side: BorderSide(
                          color: DesignConstants.secondaryTextColor,
                          width: 1.5,
                        ),
                      ),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: ClipRect(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.ellipsisVertical,
                              color: DesignConstants.primaryTextColor,
                              size: 14,
                            ),
                            AnimatedClipRect(
                              show: _showOptionsText,
                              duration: const Duration(milliseconds: 400),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    "OPTIONS",
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      textStyle: TextStyle(
                                        color: DesignConstants.primaryTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              Text(
                "TICKET OPTIONS",
                style: GoogleFonts.getFont(
                  "Roboto Condensed",
                  textStyle: TextStyle(
                    color: DesignConstants.primaryTextColor,
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: DesignConstants.primaryCardColor,
                child: ListBody(
                  children: [
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.circleInfo,
                        color: DesignConstants.primaryTextColor,
                      ),
                      title: Text(
                        "About Event",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          textStyle: TextStyle(
                            color: DesignConstants.primaryTextColor,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: DesignConstants.secondaryTextColor),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.pen,
                        color: DesignConstants.primaryTextColor,
                      ),
                      title: Text(
                        "Manage Tickets",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          textStyle: TextStyle(
                            color: DesignConstants.primaryTextColor,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: DesignConstants.secondaryTextColor),
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: address));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Copied to clipboard"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.copy,
                          color: DesignConstants.primaryTextColor,
                        ),
                        title: Text(
                          "Copy Address",
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            textStyle: TextStyle(
                              color: DesignConstants.primaryTextColor,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(color: DesignConstants.secondaryTextColor),
                    GestureDetector(
                      onTap: _openInDefaultMap,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            Platform.isIOS
                                ? 'assets/icons/apple_maps.png'
                                : 'assets/icons/google_maps.png',
                            height: 27,
                            width: 27,
                          ),
                        ),
                        title: Text(
                          "Open in $mapAppName",
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            textStyle: TextStyle(
                              color: DesignConstants.primaryTextColor,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(color: DesignConstants.secondaryTextColor),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.paperPlane,
                        color: DesignConstants.primaryTextColor,
                      ),
                      title: Text(
                        "Contact Event Host",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          textStyle: TextStyle(
                            color: DesignConstants.primaryTextColor,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: DesignConstants.secondaryTextColor),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.circleQuestion,
                        color: DesignConstants.primaryTextColor,
                      ),
                      title: Text(
                        "Frequently Asked Questions",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          textStyle: TextStyle(
                            color: DesignConstants.primaryTextColor,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: DesignConstants.secondaryTextColor),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.linkSlash,
                        color: DesignConstants.red,
                      ),
                      title: Text(
                        "Unlink Tickets from App",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          textStyle: TextStyle(
                            color: DesignConstants.red,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: DesignConstants.secondaryTextColor),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.circleExclamation,
                        color: DesignConstants.red,
                      ),
                      title: Text(
                        "Report an Issue",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          textStyle: TextStyle(
                            color: DesignConstants.red,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedClipRect extends StatefulWidget {
  final bool show;
  final Widget child;
  final Duration duration;

  const AnimatedClipRect({
    super.key,
    required this.show,
    required this.child,
    required this.duration,
  });

  @override
  State<AnimatedClipRect> createState() => _AnimatedClipRectState();
}

class _AnimatedClipRectState extends State<AnimatedClipRect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _sizeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    if (widget.show) _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedClipRect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _sizeAnimation,
      axis: Axis.horizontal,
      axisAlignment: -1.0,
      child: widget.child,
    );
  }
}
