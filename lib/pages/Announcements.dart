import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/design_constants.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 80, width: MediaQuery.sizeOf(context).width),
          Text(
            "ANNOUNCEMENTS",
            style: GoogleFonts.getFont(
              "Roboto Condensed",
              textStyle: TextStyle(
                color: DesignConstants.primaryTextColor,
                fontSize: 30,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            color: DesignConstants.primaryCardColor,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NEW",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          textStyle: TextStyle(
                            color: DesignConstants.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: DesignConstants.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: 200,
                        child: Text(
                          "Dinner is currently being served!",
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            textStyle: TextStyle(
                              color: DesignConstants.primaryTextColor,
                              fontSize: 16,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          "5:59 PM",
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            textStyle: TextStyle(
                              color: DesignConstants.secondaryTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ), // margin from screen edges
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: DesignConstants.secondaryTextColor,
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OLD ANNOUNCEMENTS',
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      textStyle: TextStyle(
                        color: DesignConstants.secondaryTextColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: DesignConstants.secondaryTextColor,
                    thickness: 2,
                  ),
                ),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            color: DesignConstants.primaryCardColor,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: 200,
                    child: Text(
                      "Come see the new artists directly from India!",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.primaryTextColor,
                          fontSize: 16,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "5:00 PM",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.secondaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            color: DesignConstants.primaryCardColor,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: 200,
                    child: Text(
                      "This is a really long announcement about someone not parking right!",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.primaryTextColor,
                          fontSize: 16,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "3:32 PM",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.secondaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            color: DesignConstants.primaryCardColor,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: 200,
                    child: Text(
                      "Lunch is currently being served!",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.primaryTextColor,
                          fontSize: 16,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "11:52 AM",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.secondaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
