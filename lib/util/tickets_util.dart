import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:barcode/barcode.dart';
import 'package:utsav_app/util/design_constants.dart';
import '../models/ticket_model.dart';

class TicketsUtil {
  /// Opens the popup for selection, builds the PDF, and returns the bytes.
  static Future<Uint8List?> _selectTicketsAndBuildPdf(
    BuildContext context,
    List<Ticket> allTickets, { // Pass the list from Provider here
    required String confirmLabel,
  }) async {
    List<bool> selected = List.generate(allTickets.length, (_) => true);

    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (context, setState) => AlertDialog(
                backgroundColor: DesignConstants.primaryCardColor,
                title: Text(
                  "Select Tickets to $confirmLabel",
                  style: GoogleFonts.getFont(
                    "Roboto Condensed",
                    fontWeight: FontWeight.bold,
                    color: DesignConstants.primaryTextColor,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: List.generate(allTickets.length, (i) {
                      final t = allTickets[i];
                      return CheckboxListTile(
                        title: Text(
                          "${t.firstName} ${t.middleName != "" ? "${t.middleName.split("")[0]}. " : ""}${t.lastName}",
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            fontWeight: FontWeight.bold,
                            color: DesignConstants.primaryTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "Ticket ${i + 1}/${allTickets.length}",
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            color: DesignConstants.primaryTextColor,
                          ),
                        ),
                        value: selected[i],
                        onChanged:
                            (val) => setState(() => selected[i] = val ?? false),
                      );
                    }),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        color: DesignConstants.primaryTextColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        DesignConstants.primaryTextColor,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      confirmLabel,
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        fontWeight: FontWeight.bold,
                        color: DesignConstants.primaryCardColor,
                      ),
                    ),
                  ),
                ],
              ),
        );
      },
    );

    if (confirmed != true) return null;

    final selectedTickets = <Ticket>[];
    for (int i = 0; i < allTickets.length; i++) {
      if (selected[i]) selectedTickets.add(allTickets[i]);
    }

    if (selectedTickets.isEmpty) return null;

    // PDF Generation Logic
    final pdf = pw.Document();
    final robotoCondensed = await PdfGoogleFonts.robotoCondensedBold();
    final logo = await networkImage(
      "https://static.wixstatic.com/media/6aea32_fcf292bdcea4480ea69f57ea11fb57b7~mv2.png/v1/fill/w_129,h_195,al_c,lg_1,q_85,enc_avif,quality_auto/utsav_logo_edited.png",
    );
    final appStoreBadge = await networkImage(
      "https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Google_Play_Store_badge_EN.svg/2560px-Google_Play_Store_badge_EN.svg.png",
    );
    final playStoreBadge = await networkImage(
      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Download_on_the_App_Store_Badge.svg/2560px-Download_on_the_App_Store_Badge.svg.png",
    );

    int i2 = 0;
    for (var ticket in selectedTickets) {
      final barcodeSvg = Barcode.pdf417().toSvg(
        ticket.barcode,
        width: 300,
        height: 80,
        drawText: false,
      );
      final int currentTicketNumber = i2 + 1;

      final instructionLines = (ticket.venueInstructions.length / 70)
          .ceil()
          .clamp(1, 4); // crude line estimate
      final topSpacing = 40 - (instructionLines - 1) * 6; // shrink ~6 per line

      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(24),
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Stack(
              children: [
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey600, width: 1.2),
                    borderRadius: pw.BorderRadius.circular(15),
                  ),
                  padding: const pw.EdgeInsets.all(16),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Center(
                        child: pw.Text(
                          "TICKET $currentTicketNumber/${selectedTickets.length}",
                          style: pw.TextStyle(
                            font: robotoCondensed,
                            fontSize: 22,
                            color: PdfColors.black,
                          ),
                        ),
                      ),

                      pw.SizedBox(height: 10),

                      pw.Center(child: pw.SvgImage(svg: barcodeSvg)),
                      pw.SizedBox(height: 16),

                      pw.Padding(
                        padding: pw.EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            _section(
                              "NAME",
                              "${ticket.firstName} ${ticket.middleName != "" ? "${ticket.middleName.split("")[0]}. " : ""}${ticket.lastName}",
                            ),
                            pw.SizedBox(height: 20),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                _section("TICKET TYPE", ticket.tier),
                                pw.SizedBox(width: 30),
                                _section(
                                  "UTSAV ID",
                                  ticket.barcode.split("-")[1],
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 16),
                            _section("VENUE", ticket.venue),
                            pw.SizedBox(height: 16),
                            _section(
                              "VENUE INSTRUCTIONS",
                              ticket.venueInstructions,
                            ),

                            pw.SizedBox(height: topSpacing.toDouble()),

                            // Light gray box with extra venue info and "What to do next?"
                            pw.Container(
                              // margin: const pw.EdgeInsets.only(top: 40),
                              padding: const pw.EdgeInsets.all(12),
                              decoration: pw.BoxDecoration(
                                color: PdfColors.grey200,
                                borderRadius: pw.BorderRadius.circular(8),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "What to do next?",
                                    style: pw.TextStyle(
                                      fontSize: 28,
                                      font: robotoCondensed,
                                      color: PdfColors.grey800,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(height: 16),

                                  // Step 1
                                  pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                        width: 28,
                                        height: 28,
                                        decoration: pw.BoxDecoration(
                                          color: PdfColors.grey800,
                                          shape: pw.BoxShape.circle,
                                        ),
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "1",
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            font: robotoCondensed,
                                            color: PdfColors.white,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(width: 12),

                                      pw.Expanded(
                                        child: pw.Text(
                                          "Download the official Utsav App to get live schedules, tickets on your phone, interactive maps, and more!",
                                          style: pw.TextStyle(
                                            fontSize: 13,
                                            font: robotoCondensed,
                                            color: PdfColors.grey800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 14),

                                  // Step 2
                                  pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                        width: 28,
                                        height: 28,
                                        decoration: pw.BoxDecoration(
                                          color: PdfColors.grey800,
                                          shape: pw.BoxShape.circle,
                                        ),
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "2",
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            font: robotoCondensed,
                                            color: PdfColors.white,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(width: 12),
                                      pw.Expanded(
                                        child: pw.Text(
                                          "Remember to RSVP for meals and find out about the vendors at the event!",
                                          style: pw.TextStyle(
                                            fontSize: 13,
                                            font: robotoCondensed,
                                            color: PdfColors.grey800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 14),

                                  // Step 3
                                  pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                        width: 28,
                                        height: 28,
                                        decoration: pw.BoxDecoration(
                                          color: PdfColors.grey800,
                                          shape: pw.BoxShape.circle,
                                        ),
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "3",
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            font: robotoCondensed,
                                            color: PdfColors.white,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(width: 12),
                                      pw.Expanded(
                                        child: pw.Text(
                                          "Finally, have the time of your life, you deserve it!",
                                          style: pw.TextStyle(
                                            fontSize: 13,
                                            font: robotoCondensed,
                                            color: PdfColors.grey800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            pw.SizedBox(height: 28),

                            // Download app prompt text
                            pw.Center(
                              child: pw.Text(
                                "DOWNLOAD THE OFFICIAL UTSAV APP NOW",
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  fontWeight: pw.FontWeight.bold,
                                  font: robotoCondensed,
                                  color: PdfColors.grey900,
                                ),
                              ),
                            ),

                            pw.SizedBox(height: 12),

                            // App store badges row
                            pw.Center(
                              child: pw.Row(
                                mainAxisSize: pw.MainAxisSize.min,
                                children: [
                                  pw.UrlLink(
                                    destination:
                                        "https://apps.apple.com/app/apple-store/idXXXXXXXXX", // Replace with actual App Store URL
                                    child: pw.Container(
                                      // width: 120,
                                      height: 40,
                                      margin: const pw.EdgeInsets.only(
                                        right: 12,
                                      ),
                                      child: pw.Image(
                                        appStoreBadge,
                                        fit: pw.BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  pw.UrlLink(
                                    destination:
                                        "https://play.google.com/store/apps/details?id=XXXXXXXXX", // Replace with actual Play Store URL
                                    child: pw.Container(
                                      // width: 140,
                                      height: 40,
                                      child: pw.Image(
                                        playStoreBadge,
                                        fit: pw.BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      pw.Spacer(),

                      // Legal boilerplate
                      pw.Center(
                        child: pw.Text(
                          "Powered by the EventX platform developed and owned by Ray Enterprises. "
                          "All rights reserved. Unauthorized duplication or resale of this ticket is strictly prohibited. "
                          "Entry to the event constitutes agreement to abide by all terms and conditions set forth by the organizers. "
                          "Tickets are non-transferable and non-refundable. "
                          "Event details are subject to change without notice. "
                          "Attendees must comply with all safety and venue regulations. "
                          "The organizer reserves the right to refuse entry or remove any individual violating event policies.",
                          style: pw.TextStyle(
                            fontSize: 7,
                            color: PdfColors.grey700,
                            fontStyle: pw.FontStyle.italic,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),

                      // Small footer text identifying the paper (using ticket holder's name)
                      pw.SizedBox(height: 4),
                      pw.Center(
                        child: pw.Text(
                          "Ticket issued to: ${ticket.firstName} ${ticket.middleName != "" ? "${ticket.middleName} " : ""}${ticket.lastName}, UID ${ticket.barcode.split("-")[1]}",
                          style: pw.TextStyle(
                            fontSize: 6,
                            color: PdfColors.grey600,
                            fontStyle: pw.FontStyle.italic,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Floating logo (doesn't affect layout)
                pw.Positioned(
                  top: 20,
                  right: 20,
                  child: pw.Container(
                    width: 60,
                    height: 90,
                    child: pw.Image(logo, fit: pw.BoxFit.contain),
                  ),
                ),
              ],
            );
          },
        ),
      );
      i2++;
    }

    return pdf.save();
  }

  // --- Public Methods ---

  static Future<void> downloadPDF(
    BuildContext context,
    List<Ticket> tickets,
  ) async {
    final pdfBytes = await _selectTicketsAndBuildPdf(
      context,
      tickets,
      confirmLabel: "Download",
    );
    if (pdfBytes != null) {
      await Printing.sharePdf(bytes: pdfBytes, filename: "Utsav_Tickets.pdf");
    }
  }

  static Future<void> printPDF(
    BuildContext context,
    List<Ticket> tickets,
  ) async {
    final pdfBytes = await _selectTicketsAndBuildPdf(
      context,
      tickets,
      confirmLabel: "Print",
    );
    if (pdfBytes != null) {
      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
        name: "Utsav_Tickets",
      );
    }
  }

  static pw.Widget _section(String title, String value) {
    // Base font size
    double fontSize = title == "NAME" ? 45 : 15;

    // If NAME is too long, reduce font size proportionally
    if (title == "NAME" && value.length > 12) {
      // Drop size by ~1.5 per extra character beyond 12
      fontSize = (45 - (value.length - 12) * 1.5).clamp(20, 45);
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey700,
          ),
        ),
        pw.Container(
          constraints: pw.BoxConstraints(maxWidth: title == "NAME" ? 400 : 600),
          child: pw.Text(
            value,
            maxLines: title == "NAME" ? 1 : 4,
            softWrap: title == "NAME" ? false : true,
            overflow: pw.TextOverflow.span,
            style: pw.TextStyle(
              fontSize: fontSize,
              fontWeight:
                  title != "VENUE INSTRUCTIONS"
                      ? pw.FontWeight.bold
                      : pw.FontWeight.normal,
              color: PdfColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
