import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/design_constants.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  _AccessibilityPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DesignConstants.backgroundColor,
        title: Text(
          "ACCESSIBILITY",
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
                SizedBox(
                  width: 240,
                  child: Text(
                    "English",
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
                    // 1. Updated List with Bengali and Native names
                    final List<Map<String, String>> allLanguages = [
                      {"en": "English", "native": ""},
                      {"en": "Bengali", "native": "বাংলা"},
                      {"en": "Hindi", "native": "हिन्दी"},
                      {"en": "Gujarati", "native": "ગુજરાતી"},
                      {"en": "Spanish", "native": "Español"},
                      {"en": "French", "native": "Français"},
                      {"en": "German", "native": "Deutsch"},
                      {"en": "Japanese", "native": "日本語"},
                      {"en": "Punjabi", "native": "ਪੰਜਾਬੀ"},
                    ];

                    // Logic Variables
                    List<Map<String, String>> filteredLanguages = List.from(
                      allLanguages,
                    );
                    int tempSelectedIndex = 0;
                    final FixedExtentScrollController scrollController =
                        FixedExtentScrollController();
                    final TextEditingController searchController =
                        TextEditingController();

                    showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.3),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStateBottomSheet) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  // 1. Limit the maximum height to 90% of the screen
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                  ),
                  // 2. Wrap everything in a SingleChildScrollView to handle small screens/keyboards
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // This is key
                      children: [
                        // --- DRAG HANDLE ---
                        Container(
                          width: 45,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        // --- TITLE ---
                        Text(
                          "SELECT LANGUAGE",
                          style: GoogleFonts.getFont(
                            'Roboto Condensed',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // --- SEARCH INPUT ---
                        TextField(
                          controller: searchController,
                          textAlign: TextAlign.center,
                          cursorColor: DesignConstants.accent,
                          style: GoogleFonts.getFont("Roboto Condensed",
                              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                          onChanged: (value) {
                            setStateBottomSheet(() {
                              filteredLanguages = allLanguages
                                  .where((lang) => lang['en']!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                              tempSelectedIndex = 0;
                              if (filteredLanguages.isNotEmpty) {
                                scrollController.jumpToItem(0);
                              }
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "SEARCH LANGUAGES",
                            hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
                            prefixIcon: const Icon(Icons.search, color: Colors.white54, size: 20),
                            filled: true,
                            fillColor: Colors.white10,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.white24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: DesignConstants.accent),
                            ),
                          ),
                        ),

                        // --- iOS WHEEL PICKER ---
                        // 3. Keep the height fixed here so it doesn't try to expand infinitely
                        SizedBox(
                          height: 180, // Reduced slightly to save space
                          child: Stack(
                            children: [
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
                                    stops: [0.0, 0.2, 0.8, 1.0],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.dstIn,
                                child: ListWheelScrollView.useDelegate(
                                  controller: scrollController,
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  diameterRatio: 1.2,
                                  physics: const FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (index) {
                                    HapticFeedback.selectionClick();
                                    setStateBottomSheet(() => tempSelectedIndex = index);
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: filteredLanguages.length,
                                    builder: (context, index) {
                                      final bool isSelected = tempSelectedIndex == index;
                                      final lang = filteredLanguages[index];

                                      return Center(
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: GoogleFonts.getFont(
                                              "Roboto Condensed",
                                              fontSize: isSelected ? 18 : 15, // Shrunk slightly for space
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                              color: isSelected ? Colors.white : Colors.white38,
                                            ),
                                            children: [
                                              TextSpan(text: lang['en']!.toUpperCase()),
                                              if (lang['native']!.isNotEmpty)
                                                TextSpan(
                                                  text: "\n${lang['native']}",
                                                  style: TextStyle(
                                                    fontFamily: 'sans-serif',
                                                    fontSize: isSelected ? 13 : 11,
                                                    color: isSelected ? DesignConstants.accent : Colors.white24,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              IgnorePointer(
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.symmetric(
                                        horizontal: BorderSide(
                                          color: Colors.white.withOpacity(0.05),
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

                        const SizedBox(height: 12),

                        // --- SAVE BUTTON ---
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (filteredLanguages.isNotEmpty) {
                                HapticFeedback.heavyImpact();
                                Navigator.pop(context, filteredLanguages[tempSelectedIndex]);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DesignConstants.accent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Text(
                              "SAVE",
                              style: GoogleFonts.getFont("Poppins",
                                  textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.8)),
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // --- CANCEL BUTTON ---
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "CANCEL",
                            style: GoogleFonts.getFont("Roboto Condensed",
                                textStyle: const TextStyle(color: Colors.white54, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
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
              "LANGUAGE",
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
                  width: 200,
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
              "CLOSED CAPTIONS",
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
                  width: 240,
                  child: Text(
                    "Email us if you still need help.",
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
              "CONTACT US",
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
