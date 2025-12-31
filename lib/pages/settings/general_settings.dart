import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/providers/theme_provider.dart';
import 'package:utsav_app/util/design_constants.dart';

class GeneralSettingsPage extends ConsumerStatefulWidget {
  const GeneralSettingsPage({super.key});

  @override
  ConsumerState<GeneralSettingsPage> createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends ConsumerState<GeneralSettingsPage> {
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
                      context: context,
                      isScrollControlled:
                          true, // Allows sheet to take up necessary space
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black.withValues(alpha: 0.3),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      builder: (context) {
                        // We use StatefulBuilder so the carousel updates when you tap a color
                        return StatefulBuilder(
                          builder: (
                            BuildContext context,
                            StateSetter setStateBottomSheet,
                          ) {
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
                                    sigmaX:
                                        5.0, // Increased slightly for better look
                                    sigmaY: 5.0,
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
                                        // --- DRAG HANDLE ---
                                        Container(
                                          width: 45,
                                          height: 4,
                                          margin: const EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),

                                        // --- TITLE ---
                                        Text(
                                          "SELECT THEME",
                                          style: GoogleFonts.getFont(
                                            'Roboto Condensed',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 30),

                                        // --- CAROUSEL (Horizontal List) ---
                                        SizedBox(
                                          height:
                                              70, // Fixed height for the carousel
                                          width: double.infinity,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount:
                                                DesignConstants
                                                    .themeOptions
                                                    .length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(width: 20),
                                            // Center the items if there are few, otherwise allow scroll
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4,
                                            ),
                                            itemBuilder: (context, index) {
                                              final bool isSelected =
                                                  DesignConstants.chosenTheme ==
                                                  index;

                                              return GestureDetector(
                                                onTap: () {
                                                  HapticFeedback.lightImpact();
                                                  setStateBottomSheet(() {
                                                    DesignConstants
                                                        .chosenTheme = index;
                                                  });
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      duration: const Duration(
                                                        milliseconds: 200,
                                                      ),
                                                      height:
                                                          isSelected ? 70 : 60,
                                                      width:
                                                          isSelected ? 70 : 60,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            DesignConstants
                                                                .themeOptions[index]
                                                                .previewColor,
                                                        border:
                                                            isSelected
                                                                ? Border.all(
                                                                  color:
                                                                      DesignConstants
                                                                          .green,
                                                                  width: 5,
                                                                )
                                                                : Border.all(
                                                                  color:
                                                                      const Color.fromARGB(59, 255, 255, 255),
                                                                  width: 3,
                                                                ),
                                                        // boxShadow: isSelected
                                                        //     ? [
                                                        //         BoxShadow(
                                                        //           color: DesignConstants
                                                        //               .themeOptions[index]
                                                        //               .previewColor
                                                        //               .withOpacity(0.5),
                                                        //           blurRadius: 10,
                                                        //           spreadRadius: 2,
                                                        //         )
                                                        //       ]
                                                        //     : [],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),

                                        const SizedBox(height: 30),

                                        // --- SAVE BUTTON ---
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              HapticFeedback.heavyImpact();
                                              // Calls the update function from your logic
                                              setState(() {
                                                DesignConstants.updateTheme();
                                                ref.read(themeProvider.notifier).state = DesignConstants.chosenTheme;
                                              });
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  DesignConstants.accent,
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
                                              "APPLY THEME",
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

                                        // --- CANCEL BUTTON ---
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
                  width: 240,
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
                    final List<String> notificationOptions = [
                      "NOTIFICATIONS OFF",
                      "URGENT ONLY",
                      "ALL NOTIFICATIONS",
                    ];
                    // Assume index 1 (Urgent Only) is currently selected
                    int tempSelectedIndex = 1;

                    // Controller to handle the scrolling physics and initial position
                    final FixedExtentScrollController scrollController =
                        FixedExtentScrollController(
                          initialItem: tempSelectedIndex,
                        );

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
                        return StatefulBuilder(
                          builder: (
                            BuildContext context,
                            StateSetter setStateBottomSheet,
                          ) {
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
                                    sigmaX: 5.0,
                                    sigmaY: 5.0,
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
                                        // --- DRAG HANDLE ---
                                        Container(
                                          width: 45,
                                          height: 4,
                                          margin: const EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),

                                        // --- TITLE ---
                                        Text(
                                          "NOTIFICATION SETTINGS",
                                          style: GoogleFonts.getFont(
                                            'Roboto Condensed',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),

                                        // --- WHEEL PICKER ---
                                        SizedBox(
                                          height:
                                              200, // Height of the visible wheel area
                                          child: Stack(
                                            children: [
                                              // 1. The Scroller
                                              // ShaderMask creates the fade-out effect at top/bottom
                                              ShaderMask(
                                                shaderCallback: (Rect bounds) {
                                                  return const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black,
                                                      Colors.black,
                                                      Colors.transparent,
                                                    ],
                                                    stops: [0.0, 0.2, 0.8, 1.0],
                                                  ).createShader(bounds);
                                                },
                                                blendMode: BlendMode.dstIn,
                                                child: ListWheelScrollView.useDelegate(
                                                  controller: scrollController,
                                                  itemExtent:
                                                      50, // Height of each item
                                                  perspective:
                                                      0.005, // Render it like a cylinder (3D effect)
                                                  diameterRatio:
                                                      1.2, // How tightly the cylinder is wrapped
                                                  physics:
                                                      const FixedExtentScrollPhysics(), // Snaps to center
                                                  onSelectedItemChanged: (
                                                    index,
                                                  ) {
                                                    HapticFeedback.selectionClick(); // The "tick" feeling
                                                    setStateBottomSheet(() {
                                                      tempSelectedIndex = index;
                                                    });
                                                  },
                                                  childDelegate: ListWheelChildBuilderDelegate(
                                                    childCount:
                                                        notificationOptions
                                                            .length,
                                                    builder: (context, index) {
                                                      final bool isSelected =
                                                          tempSelectedIndex ==
                                                          index;

                                                      // Visual logic for selected vs unselected
                                                      return Center(
                                                        child: AnimatedDefaultTextStyle(
                                                          duration:
                                                              const Duration(
                                                                milliseconds:
                                                                    200,
                                                              ),
                                                          style: GoogleFonts.getFont(
                                                            "Roboto Condensed",
                                                            fontSize:
                                                                isSelected
                                                                    ? 22
                                                                    : 18,
                                                            fontWeight:
                                                                isSelected
                                                                    ? FontWeight
                                                                        .w700
                                                                    : FontWeight
                                                                        .w400,
                                                            color:
                                                                isSelected
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .white38,
                                                            letterSpacing: 0.5,
                                                          ),
                                                          child: Text(
                                                            notificationOptions[index],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),

                                              // 2. (Optional) Subtle Selection Lines
                                              // If you want distinct lines above/below selection
                                              IgnorePointer(
                                                child: Center(
                                                  child: Container(
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                      border: Border.symmetric(
                                                        horizontal: BorderSide(
                                                          color: Colors.white
                                                              .withOpacity(0.1),
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // const SizedBox(height: 10),

                                        // --- SAVE BUTTON ---
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              HapticFeedback.heavyImpact();
                                              // Logic to save the setting goes here
                                              print(
                                                "Selected: ${notificationOptions[tempSelectedIndex]}",
                                              );
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  DesignConstants.accent,
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

                                        // --- CANCEL BUTTON ---
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
                  width: 240,
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
                    final List<String> notificationOptions = [
                      "OFF",
                      "ON",
                    ];
                    // Assume index 1 (Urgent Only) is currently selected
                    int tempSelectedIndex = 1;

                    // Controller to handle the scrolling physics and initial position
                    final FixedExtentScrollController scrollController =
                        FixedExtentScrollController(
                          initialItem: tempSelectedIndex,
                        );

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
                        return StatefulBuilder(
                          builder: (
                            BuildContext context,
                            StateSetter setStateBottomSheet,
                          ) {
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
                                    sigmaX: 5.0,
                                    sigmaY: 5.0,
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
                                        // --- DRAG HANDLE ---
                                        Container(
                                          width: 45,
                                          height: 4,
                                          margin: const EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),

                                        // --- TITLE ---
                                        Text(
                                          "DATA SAVING MODE",
                                          style: GoogleFonts.getFont(
                                            'Roboto Condensed',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),

                                        // --- WHEEL PICKER ---
                                        SizedBox(
                                          height:
                                              200, // Height of the visible wheel area
                                          child: Stack(
                                            children: [
                                              // 1. The Scroller
                                              // ShaderMask creates the fade-out effect at top/bottom
                                              ShaderMask(
                                                shaderCallback: (Rect bounds) {
                                                  return const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black,
                                                      Colors.black,
                                                      Colors.transparent,
                                                    ],
                                                    stops: [0.0, 0.2, 0.8, 1.0],
                                                  ).createShader(bounds);
                                                },
                                                blendMode: BlendMode.dstIn,
                                                child: ListWheelScrollView.useDelegate(
                                                  controller: scrollController,
                                                  itemExtent:
                                                      50, // Height of each item
                                                  perspective:
                                                      0.005, // Render it like a cylinder (3D effect)
                                                  diameterRatio:
                                                      1.2, // How tightly the cylinder is wrapped
                                                  physics:
                                                      const FixedExtentScrollPhysics(), // Snaps to center
                                                  onSelectedItemChanged: (
                                                    index,
                                                  ) {
                                                    HapticFeedback.selectionClick(); // The "tick" feeling
                                                    setStateBottomSheet(() {
                                                      tempSelectedIndex = index;
                                                    });
                                                  },
                                                  childDelegate: ListWheelChildBuilderDelegate(
                                                    childCount:
                                                        notificationOptions
                                                            .length,
                                                    builder: (context, index) {
                                                      final bool isSelected =
                                                          tempSelectedIndex ==
                                                          index;

                                                      // Visual logic for selected vs unselected
                                                      return Center(
                                                        child: AnimatedDefaultTextStyle(
                                                          duration:
                                                              const Duration(
                                                                milliseconds:
                                                                    200,
                                                              ),
                                                          style: GoogleFonts.getFont(
                                                            "Roboto Condensed",
                                                            fontSize:
                                                                isSelected
                                                                    ? 22
                                                                    : 18,
                                                            fontWeight:
                                                                isSelected
                                                                    ? FontWeight
                                                                        .w700
                                                                    : FontWeight
                                                                        .w400,
                                                            color:
                                                                isSelected
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .white38,
                                                            letterSpacing: 0.5,
                                                          ),
                                                          child: Text(
                                                            notificationOptions[index],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),

                                              // 2. (Optional) Subtle Selection Lines
                                              // If you want distinct lines above/below selection
                                              IgnorePointer(
                                                child: Center(
                                                  child: Container(
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                      border: Border.symmetric(
                                                        horizontal: BorderSide(
                                                          color: Colors.white
                                                              .withOpacity(0.1),
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // const SizedBox(height: 10),

                                        // --- SAVE BUTTON ---
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              HapticFeedback.heavyImpact();
                                              // Logic to save the setting goes here
                                              print(
                                                "Selected: ${notificationOptions[tempSelectedIndex]}",
                                              );
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  DesignConstants.accent,
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

                                        // --- CANCEL BUTTON ---
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
