import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/providers/announcement_provider.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:utsav_app/widgets/announcement_card.dart';
import 'package:utsav_app/widgets/announcement_skeleton.dart';
import 'package:utsav_app/widgets/no_announcements_card.dart';

class AnnouncementsPage extends ConsumerStatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  ConsumerState<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends ConsumerState<AnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final announcementsAsync = ref.watch(announcementsProvider);

    return Column(
      children: [
        SizedBox(height: 50, width: MediaQuery.sizeOf(context).width),
        Text(
          "ANNOUNCEMENTS",
          style: GoogleFonts.getFont(
            "Roboto Condensed",
            textStyle: TextStyle(
              color: DesignConstants.primaryTextColor,
              fontSize: 34,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 0),
        Expanded(
          child: RefreshIndicator(
            displacement: 20,
            onRefresh: () async {
              HapticFeedback.mediumImpact();
              await ref.read(announcementsProvider.notifier).refresh();
            },
            backgroundColor: DesignConstants.primaryCardColorLight,
            color: DesignConstants.accent,
            child: announcementsAsync.when(
              data: (announcements) {
                print(announcements);
                if (announcements.isEmpty) {
                  return const NoAnnouncementsWidget();
                }

                // Find where the 'Old' section starts
                final firstReadIndex = announcements.indexWhere(
                  (a) => a.isRead,
                );

                // If we have both Unread and Read, we add 1 to the count for the divider
                final showDivider = firstReadIndex != -1 && firstReadIndex != 0;
                final itemCount =
                    showDivider
                        ? announcements.length + 1
                        : announcements.length;

                return ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    // If this specific index is the divider position
                    if (showDivider && index == firstReadIndex) {
                      return _buildOldDivider();
                    }

                    // Adjust the data index if we are past the divider
                    final dataIndex =
                        (showDivider && index > firstReadIndex)
                            ? index - 1
                            : index;
                    final announcement = announcements[dataIndex];

                    return AnnouncementCard(
                      announcement: announcement,
                      onTap:
                          () => ref
                              .read(announcementsProvider.notifier)
                              .markAsRead(dataIndex),
                    );
                  },
                );
              },
              loading:
                  () => ListView.builder(
                    shrinkWrap:
                        true, // If used inside a Column, ensure parent is Expanded
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => const MediumCardSkeleton(),
                  ),
              error:
                  (err, stack) =>
                      ErrorAnnouncementsWidget(errorMessage: err.toString()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOldDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
                  fontWeight: FontWeight.bold,
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
    );
  }
}
