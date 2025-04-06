import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/design_constants.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  _AboutAppPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DesignConstants.backgroundColor,
        title: Text(
          "ABOUT APP",
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
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://static.wixstatic.com/media/6aea32_fcf292bdcea4480ea69f57ea11fb57b7~mv2.png/v1/fill/w_129,h_195,al_c,lg_1,q_85,enc_avif,quality_auto/utsav_logo_edited.png",
                    height: 70,
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    DesignConstants
                            .themeOptions[DesignConstants.chosenTheme]
                            .isDark
                        ? "assets/logos/Ray Enterprises White.png"
                        : "assets/logos/Ray Enterprises Black.png",
                    width: MediaQuery.of(context).size.width - 70,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    "The Utsav App and the EventX Platform is developed by and the sole property of Ray Enterprises.",
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
              ],
            ),
            Text(
              "ABOUT RAY ENTERPRISES",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.secondaryTextColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DesignConstants.secondaryTextColor,
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
                        color: DesignConstants.primaryTextColor,
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
                    "VIEW >",
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
              "LICENSES",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.secondaryTextColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DesignConstants.secondaryTextColor,
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
                    "Build Version",
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
              ],
            ),
            Text(
              "0.122.1 17165742",
              style: GoogleFonts.getFont(
                "Roboto Condensed",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: DesignConstants.secondaryTextColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DesignConstants.secondaryTextColor,
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
