import 'dart:ui';

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
        // actions: [
        //   GestureDetector(
        //     onTap: () {},
        //     child: Text(
        //               "SAVE",
        //               style: GoogleFonts.getFont(
        //     'Roboto Condensed',
        //     fontWeight: FontWeight.w200,
        //     textStyle: TextStyle(color: DesignConstants.primaryTextColor),
        //               )),
        //   )
        // ],
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
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.widthOf(context) * 0.65,
                        ),
                        child: Text(
                          "john.smith009@gmail.com",
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: DesignConstants.primaryTextColor,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.black.withValues(alpha: 0.3),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 2.5,
                                      sigmaY: 2.5,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        24,
                                        18,
                                        24,
                                        28,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.6,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 45,
                                            height: 4,
                                            margin: const EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          Text(
                                            "UPDATE EMAIL",
                                            style: GoogleFonts.getFont(
                                              'Roboto Condensed',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          TextField(
                                            autofocus: true,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textAlign: TextAlign.center,
                                            cursorColor: DesignConstants.green,
                                            style: GoogleFonts.getFont(
                                              "Roboto Condensed",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "ENTER NEW EMAIL",
                                              hintStyle: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 15,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white10,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                    horizontal: 16,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                  color: Colors.white24,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                  color: DesignConstants.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 28),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                HapticFeedback.heavyImpact();
                                                // TODO: Handle save email logic
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    DesignConstants.green,
                                                foregroundColor: Colors.black,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                              ),
                                              child: Text(
                                                "SAVE",
                                                style: GoogleFonts.getFont(
                                                  "Poppins",
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 13,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: Text(
                                              "CANCEL",
                                              style: GoogleFonts.getFont(
                                                "Roboto Condensed",
                                                textStyle: const TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
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
                    "EMAIL",
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
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.widthOf(context) * 0.65,
                        ),
                        child: Text(
                          "053467",
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: DesignConstants.primaryTextColor,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.black.withValues(alpha: 0.3),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 2.5,
                                      sigmaY: 2.5,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        24,
                                        18,
                                        24,
                                        28,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.6,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 45,
                                            height: 4,
                                            margin: const EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          Text(
                                            "ENTER UTSAV ID",
                                            style: GoogleFonts.getFont(
                                              'Roboto Condensed',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 24),

                                          // --- 6-Digit Input Boxes ---
                                          _UtsavIdInputField(),

                                          const SizedBox(height: 28),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                HapticFeedback.heavyImpact();
                                                // TODO: Handle Utsav ID save logic
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    DesignConstants.green,
                                                foregroundColor: Colors.black,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                              ),
                                              child: Text(
                                                "SAVE",
                                                style: GoogleFonts.getFont(
                                                  "Poppins",
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 13,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: Text(
                                              "CANCEL",
                                              style: GoogleFonts.getFont(
                                                "Roboto Condensed",
                                                textStyle: const TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
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
                    "UTSAV ID",
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
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.widthOf(context) * 0.65,
                        ),
                        child: Text(
                          "Smith",
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: DesignConstants.primaryTextColor,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.black.withValues(alpha: 0.3),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 2.5,
                                      sigmaY: 2.5,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        24,
                                        18,
                                        24,
                                        28,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.6,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 45,
                                            height: 4,
                                            margin: const EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          Text(
                                            "UPDATE LAST NAME",
                                            style: GoogleFonts.getFont(
                                              'Roboto Condensed',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          TextField(
                                            autofocus: true,
                                            keyboardType:
                                                TextInputType.name,
                                                textCapitalization: TextCapitalization.words,
                                            textAlign: TextAlign.center,
                                            cursorColor: DesignConstants.green,
                                            style: GoogleFonts.getFont(
                                              "Roboto Condensed",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "ENTER NEW LAST NAME",
                                              hintStyle: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 15,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white10,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                    horizontal: 16,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                  color: Colors.white24,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                  color: DesignConstants.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 28),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                HapticFeedback.heavyImpact();
                                                // TODO: Handle save email logic
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    DesignConstants.green,
                                                foregroundColor: Colors.black,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                              ),
                                              child: Text(
                                                "SAVE",
                                                style: GoogleFonts.getFont(
                                                  "Poppins",
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 13,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: Text(
                                              "CANCEL",
                                              style: GoogleFonts.getFont(
                                                "Roboto Condensed",
                                                textStyle: const TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
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
                    "LAST NAME",
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
                          "DELETE >",
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
            ],
          ),
        ),
      ),
    );
  }
}

class _UtsavIdInputField extends StatefulWidget {
  @override
  State<_UtsavIdInputField> createState() => _UtsavIdInputFieldState();
}

class _UtsavIdInputFieldState extends State<_UtsavIdInputField> {
  final int length = 6;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(length, (_) => TextEditingController());
    focusNodes = List.generate(length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate max width per box (with some margin) to avoid overflow on small screens
    final boxWidth =
        (screenWidth - 80) /
        length; // 60 is total horizontal padding/margin approx

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          width: boxWidth.clamp(40, 50), // clamp for min 40, max 55 width
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            textAlignVertical:
                TextAlignVertical.center, // <-- vertical center fix
            maxLength: 1,
            cursorColor: DesignConstants.green,
            style: GoogleFonts.getFont(
              "Roboto Condensed",
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              counterText: "",
              isDense: true, // removes extra vertical padding
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
              ), // remove vertical padding
              filled: true,
              fillColor: Colors.white10,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: DesignConstants.green,
                  width: 1.5,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < length - 1) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }
}
