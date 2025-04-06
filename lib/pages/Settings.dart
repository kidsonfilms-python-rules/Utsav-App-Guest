import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/pages/settings/about_app.dart';
import 'package:utsav_app/pages/settings/accessibility.dart';
import 'package:utsav_app/pages/settings/general_settings.dart';
import 'package:utsav_app/pages/settings/help.dart';
import 'package:utsav_app/pages/settings/legal.dart';
import 'package:utsav_app/pages/settings/profile.dart';
import 'package:utsav_app/util/DesignConstants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConstants.BACKGROUND_COLOR,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DesignConstants.BACKGROUND_COLOR,
        foregroundColor: DesignConstants.TEXT_PRIMARY_COLOR,
        title: Text(
          "SETTINGS",
          style: GoogleFonts.getFont('Roboto Condensed',
              // fontWeight: FontWeight.w200,
              textStyle: TextStyle(color: DesignConstants.TEXT_PRIMARY_COLOR)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19.0),
                ),
                color: DesignConstants.PRIMARY_CARD_COLOR,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        GeneralSettingsPage(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: Icon(FontAwesomeIcons.gear, color: DesignConstants.TEXT_PRIMARY_COLOR,)
                              ),
                              const SizedBox(width: 35),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "General",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                    ),
                                  ),
                                  Text(
                                    "App Theme · Notifications",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 65,
                          bottom: 10,
                          top: 10,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(155, 155, 155, 0.5),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        AccountSettingsPage(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: Icon(FontAwesomeIcons.userGear, color: DesignConstants.TEXT_PRIMARY_COLOR,)
                              ),
                              const SizedBox(width: 35),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                    ),
                                  ),
                                  Text(
                                    "Security · Details · Sign out",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.5,
                                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 65,
                          bottom: 10,
                          top: 10,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(155, 155, 155, 0.5),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AccessibilityPage(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: Icon(FontAwesomeIcons.universalAccess, color: DesignConstants.TEXT_PRIMARY_COLOR,)
                              ),
                              const SizedBox(width: 35),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Accessibility",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                    ),
                                  ),
                                  Text(
                                    "Language · Captions",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19.0),
                ),
                color: DesignConstants.PRIMARY_CARD_COLOR,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 16.0, bottom: 16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: Icon(FontAwesomeIcons.solidBell, color: DesignConstants.TEXT_PRIMARY_COLOR,)
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subscriptions",
                                  style: GoogleFonts.getFont("Roboto Condensed",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: DesignConstants.TEXT_PRIMARY_COLOR),
                                ),
                                Text(
                                  "Events · Announcements",
                                  style: GoogleFonts.getFont("Roboto Condensed",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: DesignConstants.TEXT_SECONDARY_COLOR),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 65, bottom: 10, top: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Color.fromRGBO(155, 155, 155, 0.5),
                                width: 1.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: Icon(FontAwesomeIcons.utensils, color: DesignConstants.TEXT_PRIMARY_COLOR,)
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Meal Preferences",
                                  style: GoogleFonts.getFont("Roboto Condensed",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: DesignConstants.TEXT_PRIMARY_COLOR),
                                ),
                                Text(
                                  "Vegetarian · Allergies · Children",
                                  style: GoogleFonts.getFont("Roboto Condensed",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.75,
                                      color: DesignConstants.TEXT_SECONDARY_COLOR),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 65, bottom: 10, top: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Color.fromRGBO(155, 155, 155, 0.5),
                                width: 1.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: Icon(FontAwesomeIcons.moneyCheckDollar, color: DesignConstants.TEXT_PRIMARY_COLOR,)
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Methods",
                                  style: GoogleFonts.getFont("Roboto Condensed",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: DesignConstants.TEXT_PRIMARY_COLOR),
                                ),
                                Text(
                                  "Set payment method · Reciepts",
                                  style: GoogleFonts.getFont("Roboto Condensed",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: DesignConstants.TEXT_SECONDARY_COLOR),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19.0),
                ),
                color: DesignConstants.PRIMARY_CARD_COLOR,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 16.0),
                      //   child: Row(
                      //     children: [
                      //       SizedBox(
                      //         width: 32,
                      //         height: 32,
                      //         child: SvgPicture.asset(
                      //             "assets/images/icons/app_settings.svg"),
                      //       ),
                      //       const SizedBox(
                      //         width: 35,
                      //       ),
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "App Settings",
                      //             style: GoogleFonts.getFont("Roboto Condensed",
                      //                 fontWeight: FontWeight.w600,
                      //                 fontSize: 20,
                      //                 color: DesignConstants.TEXT_PRIMARY_COLOR),
                      //           ),
                      //           Text(
                      //             "Accessibility · Display · Animations",
                      //             style: GoogleFonts.getFont("Roboto Condensed",
                      //                 fontWeight: FontWeight.w400,
                      //                 fontSize: 12,
                      //                 color: DesignConstants.TEXT_SECONDARY_COLOR),
                      //           ),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.only(
                      //       left: 65, bottom: 10, top: 10),
                      //   decoration: const BoxDecoration(
                      //     border: Border(
                      //       bottom: BorderSide(
                      //           color: Color.fromRGBO(155, 155, 155, 0.5),
                      //           width: 1.0),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: Icon(FontAwesomeIcons.solidCircleQuestion, color: DesignConstants.TEXT_PRIMARY_COLOR,)
                              ),
                              const SizedBox(width: 35),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Help",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                    ),
                                  ),
                                  Text(
                                    "Report an issue · Contact us",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 65,
                          bottom: 10,
                          top: 10,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(155, 155, 155, 0.5),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppLegalPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: Icon(FontAwesomeIcons.scaleBalanced, color: DesignConstants.TEXT_PRIMARY_COLOR,)
                              ),
                              const SizedBox(width: 35),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Legal",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                    ),
                                  ),
                                  Text(
                                    "Privacy · Terms of Use",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 65,
                          bottom: 10,
                          top: 10,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(155, 155, 155, 0.5),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutAppPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: Icon(FontAwesomeIcons.circleInfo, color: DesignConstants.TEXT_PRIMARY_COLOR,)
                              ),
                              const SizedBox(width: 35),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "About App",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                    ),
                                  ),
                                  Text(
                                    "Ray Enterprises · Licenses",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
