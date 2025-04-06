import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/design_constants.dart';

class GeneralSettingsPage extends StatefulWidget {
  const GeneralSettingsPage({super.key});

  @override
  State<GeneralSettingsPage> createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage> {
  _GeneralSettingsPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DesignConstants.backgroundColor,
        title: Text(
          "GENERAL",
          style: GoogleFonts.getFont(
            'Roboto Condensed',
            fontWeight: FontWeight.w200,
            textStyle: TextStyle(color: DesignConstants.primaryTextColor),
          ),
        ),
        foregroundColor: DesignConstants.primaryTextColor,
      ),
      backgroundColor: DesignConstants.backgroundColor,
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
                    border: Border.all(
                      color: DesignConstants.secondaryTextColor,
                      width: 2,
                    ),
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
                                                      .primaryTextColor,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 40),
                                        Flexible(
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
                                                                      .green,
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
                      color: DesignConstants.secondaryTextColor,
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
                color: DesignConstants.secondaryTextColor,
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
                    "All Allowed",
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      textStyle: TextStyle(
                        color: DesignConstants.primaryTextColor,
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
                    "CHANGE >",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.secondaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "NOTIFICATIONS",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.secondaryTextColor,
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
                    "Off",
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      textStyle: TextStyle(
                        color: DesignConstants.primaryTextColor,
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
                    "CHANGE >",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.secondaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "DATA SAVING MODE",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.secondaryTextColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25, top: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(155, 155, 155, 0.5),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => {},
                style: ButtonStyle(
                  enableFeedback: true,
                  foregroundColor: WidgetStateProperty.all(DesignConstants.red),
                  side: WidgetStateProperty.all(
                    BorderSide(
                      color: const Color.fromRGBO(255, 63, 63, 1),
                      width: 2,
                    ),
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.fromLTRB(55, 10, 55, 10),
                  ),
                ),
                child: Text(
                  "SIGN OUT",
                  style: GoogleFonts.getFont(
                    'Roboto Condensed',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    textStyle: TextStyle(
                      color: const Color.fromRGBO(255, 63, 63, 1),
                    ),
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
