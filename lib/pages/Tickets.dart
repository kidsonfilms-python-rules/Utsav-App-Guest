import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/DesignConstants.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:utsav_app/widgets/AnimatedCarouselIndicator.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  final CarouselSliderController controller = CarouselSliderController();
  var _activeTicketView = 0;

  void _onDotTapped(int index) {
    HapticFeedback.selectionClick();
    controller.animateToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50, width: MediaQuery.sizeOf(context).width),
          Text(
            "TICKETS",
            style: GoogleFonts.getFont(
              "Roboto Condensed",
              textStyle: TextStyle(
                color: DesignConstants.TEXT_PRIMARY_COLOR,
                fontSize: 30,
                fontStyle: FontStyle.normal,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height - 200,
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
                      color: DesignConstants.PRIMARY_CARD_COLOR,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "TICKET ${index + 1}",
                              style: GoogleFonts.getFont(
                                "Roboto Condensed",
                                textStyle: TextStyle(
                                  color: DesignConstants.TEXT_SECONDARY_COLOR,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                            Container(
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
                                                .TEXT_SECONDARY_COLOR,
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
                                            DesignConstants.TEXT_PRIMARY_COLOR,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
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
                                                    .TEXT_SECONDARY_COLOR,
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
                                                    .TEXT_PRIMARY_COLOR,
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
                                                    .TEXT_SECONDARY_COLOR,
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
                                                    .TEXT_PRIMARY_COLOR,
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
                            Container(
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
                                                .TEXT_SECONDARY_COLOR,
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
                                            DesignConstants.TEXT_PRIMARY_COLOR,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
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
                                                .TEXT_SECONDARY_COLOR,
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
                                            DesignConstants.TEXT_PRIMARY_COLOR,
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
          AnimatedCarouselIndicator(
            itemCount: 4,
            activeIndex: _activeTicketView,
            activeIndicatorColor: DesignConstants.TEXT_PRIMARY_COLOR,
            inactiveIndicatorColor: DesignConstants.TEXT_SECONDARY_COLOR,
            onDotTapped: _onDotTapped,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
