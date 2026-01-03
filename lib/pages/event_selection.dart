import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/main.dart';
import 'package:utsav_app/util/design_constants.dart';

class EventsSelectionPage extends StatelessWidget {
  const EventsSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Center(
                child: Text(
                  "EVENTS",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    "Roboto Condensed",
                    textStyle: TextStyle(
                      color: DesignConstants.primaryTextColor,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Select an event to continue",
                  style: GoogleFonts.getFont(
                    "Roboto Condensed",
                    textStyle: TextStyle(
                      color: DesignConstants.secondaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Added specific icons for the "vibe"
              const SelectionCard(
                title: "SARASWATI PUJA", 
                label: "SPRING 2026", 
                bgIcon: FontAwesomeIcons.bookOpenReader
              ),
              const SelectionCard(
                title: "GBM ANNUAL PICNIC", 
                label: "SUMMER 2026", 
                bgIcon: Icons.wb_sunny 
              ),
              const SelectionCard(
                title: "DURGA PUJA", 
                label: "AUTUMN 2026", 
                bgIcon: Icons.temple_hindu_outlined
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectionCard extends StatefulWidget {
  final String title;
  final String label;
  final IconData bgIcon; // New parameter for background graphic

  const SelectionCard({
    super.key, 
    required this.title, 
    required this.label, 
    required this.bgIcon
  });

  @override
  State<SelectionCard> createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {
  bool _isSelected = false;

  void _handleTap() async {
    if (_isSelected) return;
    HapticFeedback.mediumImpact();
    
    setState(() => _isSelected = true);

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = _isSelected ? Colors.black : DesignConstants.primaryTextColor;
    final Color labelColor = _isSelected ? Colors.black.withOpacity(0.7) : DesignConstants.accent;
    final Color iconColor = _isSelected ? Colors.black.withOpacity(0.5) : DesignConstants.primaryTextColor.withOpacity(0.3);
    
    // FIXED: Using very low opacities for the "barely visible" effect
    // 0.03 opacity is almost invisible, creating that subtle watermark vibe
    final Color bgGraphicColor = _isSelected 
        ? Colors.black.withOpacity(0.07) 
        : Colors.white.withOpacity(0.03);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: _handleTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // 1. BASE BACKGROUND
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                color: DesignConstants.primaryCardColor,
                child: Opacity(
                  opacity: 0,
                  child: _buildContent(labelColor, textColor, iconColor),
                ),
              ),

              // 2. THE WIPE LAYER
              Positioned.fill(
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      width: _isSelected ? MediaQuery.of(context).size.width : 0,
                      color: DesignConstants.accent,
                    ),
                  ],
                ),
              ),

              // 3. THE BACKGROUND GRAPHIC
              // FIXED: Explicitly passing the color to the Icon widget
              Positioned(
                right: -25, // Pushed slightly further out
                bottom: -25,
                child: IgnorePointer(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      widget.bgIcon,
                      size: 140, // Slightly larger for better "bleed"
                      color: bgGraphicColor, // FIXED: Explicit color assignment
                    ),
                  ),
                ),
              ),

              // 4. THE ACTUAL CONTENT
              _buildContent(labelColor, textColor, iconColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Color labelColor, Color textColor, Color iconColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.getFont(
              "Roboto Condensed",
              textStyle: TextStyle(
                color: labelColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            child: Text(widget.label),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: GoogleFonts.getFont(
                    "Roboto Condensed",
                    textStyle: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(widget.title),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: iconColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}