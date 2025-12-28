import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/design_constants.dart';

class UtsavIdInputField extends StatefulWidget {
  const UtsavIdInputField({super.key});

  @override
  State<UtsavIdInputField> createState() => UtsavIdInputFieldState();
}

class UtsavIdInputFieldState extends State<UtsavIdInputField> {
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
    final boxWidth = (screenWidth - 80) / length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          width: boxWidth.clamp(40, 50),
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,

            // Horizontal alignment
            textAlign: TextAlign.center,

            // Vertical alignment
            textAlignVertical: TextAlignVertical.center,

            // Remove expands: true as it can interfere with horizontal centering
            expands: false,

            cursorColor: DesignConstants.accent,
            style: GoogleFonts.getFont(
              "Roboto Condensed",
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
              height: 1.0,
            ),
            decoration: InputDecoration(
              counterText: "",
              isDense: true,

              // ADJUST THIS:
              // Since your Container height is 55 and your font size is 22,
              // the text needs roughly 16-17px of padding to be perfectly centered.
              contentPadding: const EdgeInsets.symmetric(vertical: 16),

              filled: true,
              fillColor: Colors.white10,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: DesignConstants.accent,
                  width: 1.5,
                ),
              ),
            ),
            onChanged: (value) {
              // 1. HANDLE PASTE
              if (value.length > 2) {
                for (int i = 0; i < value.length; i++) {
                  if (index + i < length) {
                    controllers[index + i].text = value[i];
                  }
                }
                int nextIndex = index + value.length;
                if (nextIndex >= length) nextIndex = length - 1;
                FocusScope.of(context).requestFocus(focusNodes[nextIndex]);
                return;
              }

              // 2. HANDLE REPLACE
              if (value.length > 1) {
                String newChar = value.substring(value.length - 1);
                controllers[index].text = newChar;
                controllers[index].selection = TextSelection.fromPosition(
                  const TextPosition(offset: 1),
                );
                if (index < length - 1) {
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                }
              }
              // 3. STANDARD TYPING
              else if (value.isNotEmpty) {
                if (index < length - 1) {
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                }
              }
              // 4. BACKSPACE
              else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }
}
