import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/DesignConstants.dart';

class GeneralSettingsPage extends StatefulWidget {
  const GeneralSettingsPage({Key? key}) : super(key: key);

  @override
  _GeneralSettingsPageState createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage> {
  _GeneralSettingsPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DesignConstants.BACKGROUND_COLOR,
        title: Text(
          "GENERAL",
          style: GoogleFonts.getFont(
            'Roboto Condensed',
            fontWeight: FontWeight.w200,
            textStyle: TextStyle(color: DesignConstants.TEXT_PRIMARY_COLOR),
          ),
        ),
        foregroundColor: DesignConstants.TEXT_PRIMARY_COLOR,
      ),
      backgroundColor: DesignConstants.BACKGROUND_COLOR,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color:
                        DesignConstants
                            .themeOptions[DesignConstants.chosenTheme]
                            .previewColor,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      // backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (
                            BuildContext context,
                            StateSetter setStateBottomSheet,
                          ) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 20.0,
                                  sigmaY: 20.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    border: Border.all(
                                      color: Colors.black26,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 20),
                                        Text(
                                          "CHANGE APP THEME",
                                          style: GoogleFonts.getFont(
                                            'Roboto Condensed',
                                            fontWeight: FontWeight.w200,
                                            textStyle: TextStyle(
                                              color:
                                                  DesignConstants
                                                      .TEXT_PRIMARY_COLOR,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 40),
                                        Expanded(
                                          child: GridView.builder(
                                            itemCount:
                                                DesignConstants
                                                    .themeOptions
                                                    .length,
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 50,
                                                  childAspectRatio: 1,
                                                  mainAxisExtent: 50,
                                                  crossAxisSpacing: 20,
                                                  mainAxisSpacing: 20,
                                                ),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  HapticFeedback.heavyImpact();
                                                  setStateBottomSheet(() {
                                                    DesignConstants
                                                        .chosenTheme = index;
                                                  });
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          25,
                                                        ),
                                                    color:
                                                        DesignConstants
                                                            .themeOptions[index]
                                                            .previewColor,
                                                    border:
                                                        index ==
                                                                DesignConstants
                                                                    .chosenTheme
                                                            ? Border.all(
                                                              color:
                                                                  DesignConstants
                                                                      .GREEN,
                                                              width: 3,
                                                            )
                                                            : null,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   height: 20,
                                        // ),
                                        OutlinedButton(
                                          onPressed: () {
                                            HapticFeedback.heavyImpact();
                                            setState(() {
                                              DesignConstants.updateTheme();
                                            });
                                            Navigator.pop(context);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.all(16.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(34.0),
                                            ),
                                            side: const BorderSide(
                                              width: 2.0,
                                              color: Color.fromRGBO(
                                                90,
                                                255,
                                                63,
                                                1,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "SAVE",
                                            style: GoogleFonts.getFont(
                                              "Roboto Condensed",
                                              textStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                  90,
                                                  255,
                                                  63,
                                                  1,
                                                ),
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    "CHANGE >",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "APP THEME",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.TEXT_SECONDARY_COLOR,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(155, 155, 155, 0.5),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    "By using the Utsav app, you agree to our Terms of Service",
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      textStyle: TextStyle(
                        color: DesignConstants.TEXT_PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                  },
                  child: Text(
                    "SEE >",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "TERMS OF SERVICE",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.TEXT_SECONDARY_COLOR,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(155, 155, 155, 0.5),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    "By using the Utsav app, you agree to our Privacy Policy",
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      textStyle: TextStyle(
                        color: DesignConstants.TEXT_PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                  },
                  child: Text(
                    "SEE >",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "PRIVACY POLICY",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.TEXT_SECONDARY_COLOR,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(155, 155, 155, 0.5),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    "See open-source licenses",
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      textStyle: TextStyle(
                        color: DesignConstants.TEXT_PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    showLicensePage(
                      context: context,
                      applicationName: "The Utsav App",
                      applicationLegalese: "DEVELOPED BY RAY ENTERPRISES",
                      applicationIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            "https://static.wixstatic.com/media/6aea32_fcf292bdcea4480ea69f57ea11fb57b7~mv2.png/v1/fill/w_129,h_195,al_c,lg_1,q_85,enc_avif,quality_auto/utsav_logo_edited.png",
                            height: 70,
                          ),
                          SizedBox(height: 10),
                          Image.asset(
                            "assets/logos/Ray Enterprises Black.png",
                            width: MediaQuery.of(context).size.width - 70,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    "SEE >",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.TEXT_SECONDARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "LICENSES",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.TEXT_SECONDARY_COLOR,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DesignConstants.TEXT_SECONDARY_COLOR,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
