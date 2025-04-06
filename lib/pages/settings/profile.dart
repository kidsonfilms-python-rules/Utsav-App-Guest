import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/design_constants.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  _AccountSettingsPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DesignConstants.backgroundColor,
        title: Text(
          "ACCOUNT",
          style: GoogleFonts.getFont(
            'Roboto Condensed',
            fontWeight: FontWeight.w200,
            textStyle: TextStyle(color: DesignConstants.primaryTextColor),
          ),
        ),
        foregroundColor: DesignConstants.primaryTextColor,
      ),
      backgroundColor: DesignConstants.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: DesignConstants.secondaryTextColor,
                    ),
                  ),
                  TextField(
                    controller:
                        TextEditingController()..text = 'john.smith@gmail.com',
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Your email...",
                      hintStyle: GoogleFonts.getFont(
                        "Roboto Condensed",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: DesignConstants.secondaryTextColor,
                      ),
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.primaryTextColor,
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Utsav ID",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: DesignConstants.secondaryTextColor,
                    ),
                  ),
                  TextField(
                    // enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Your email...",
                      hintStyle: GoogleFonts.getFont(
                        "Roboto Condensed",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: DesignConstants.secondaryTextColor,
                      ),
                    ),
                    controller: TextEditingController()..text = '053467',
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.primaryTextColor,
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Last Name",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: DesignConstants.secondaryTextColor,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Your name...",
                      hintStyle: GoogleFonts.getFont(
                        "Roboto Condensed",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: DesignConstants.secondaryTextColor,
                      ),
                    ),
                    controller: TextEditingController()..text = 'Smith',
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    maxLines: 1,
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: DesignConstants.primaryTextColor,
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      "Reset your password",
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
                      "RESET >",
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
                "RESET PASSWORD",
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
                    width: 200,
                    child: Text(
                      "Deactivate/Delete Account",
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
                      "OPEN >",
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
                "DEACTIVATE ACCOUNT",
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
                    width: 200,
                    child: Text(
                      "Request my data",
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
                      "REQUEST >",
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
                "CCPA COMPLIANCE",
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
                    foregroundColor: WidgetStateProperty.all(
                      DesignConstants.red,
                    ),
                    side: WidgetStateProperty.all(
                      BorderSide(color: DesignConstants.red, width: 2),
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
                      textStyle: TextStyle(color: DesignConstants.red),
                    ),
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
