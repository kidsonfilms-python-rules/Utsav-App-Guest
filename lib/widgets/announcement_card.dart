import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:utsav_app/models/announcement_model.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:utsav_app/widgets/markdown_text.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback? onTap;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Logic to toggle state
    final bool isNew = !announcement.isRead;
    final String formattedTime = DateFormat.jm().format(announcement.date);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        color: DesignConstants.primaryCardColor,
        child: Container(
          padding: const EdgeInsets.all(15),
          // If new, we use a Column to stack the Header + Content
          // If read, we just return the Content Row (mimicking your 2nd snippet)
          child: isNew
              ? Column(
                  children: [
                    _buildNewHeader(),
                    _buildContentRow(formattedTime, marginTop: 10),
                  ],
                )
              : _buildContentRow(formattedTime, marginTop: 0),
        ),
      ),
    );
  }

  // Exact replication of your "NEW" header row
  Widget _buildNewHeader() {
    return Row(
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
    );
  }

  // Exact replication of your content row with dynamic margin support
  Widget _buildContentRow(String time, {required double marginTop}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, marginTop, 0, 0),
          width: 200,
          // Preserving your exact MarkdownText logic
          child: MarkdownText(
            announcement.message,
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
          margin: EdgeInsets.fromLTRB(0, marginTop, 0, 0),
          child: Text(
            time,
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
    );
  }
}