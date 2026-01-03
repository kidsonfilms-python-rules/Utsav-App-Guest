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
  final Function(bool) onScroll;
  const AnnouncementsPage({super.key, required this.onScroll});

  @override
  ConsumerState<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends ConsumerState<AnnouncementsPage> {
  // Add a ScrollController to track position for the MainPage AppBar
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Logic for triggering the Native App Bar in MainPage
      if (_scrollController.offset > 110) {
        widget.onScroll(true);
      } else {
        widget.onScroll(false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final announcementsAsync = ref.watch(announcementsProvider);

    return RefreshIndicator(
      displacement: 50,
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        await ref.read(announcementsProvider.notifier).refresh();
      },
      backgroundColor: DesignConstants.primaryCardColorLight,
      color: DesignConstants.accent,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works even if list is short
        child: Column(
          children: [
            // TITLE IS NOW INSIDE THE SCROLL VIEW
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
            const SizedBox(height: 20),

            // CONTENT AREA
            announcementsAsync.when(
              data: (announcements) {
                if (announcements.isEmpty) {
                  return const NoAnnouncementsWidget();
                }

                final firstReadIndex = announcements.indexWhere((a) => a.isRead);
                final showDivider = firstReadIndex != -1 && firstReadIndex != 0;

                return Column(
                  children: [
                    ...List.generate(
                      showDivider ? announcements.length + 1 : announcements.length,
                      (index) {
                        if (showDivider && index == firstReadIndex) {
                          return _buildOldDivider();
                        }

                        final dataIndex = (showDivider && index > firstReadIndex)
                            ? index - 1
                            : index;
                        final announcement = announcements[dataIndex];

                        return AnnouncementCard(
                          announcement: announcement,
                          onTap: () => ref
                              .read(announcementsProvider.notifier)
                              .markAsRead(dataIndex),
                        );
                      },
                    ),
                    const SizedBox(height: 100), // Bottom padding for GNav
                  ],
                );
              },
              loading: () => Column(
                children: List.generate(
                  5,
                  (index) => const MediumCardSkeleton(),
                ),
              ),
              error: (err, stack) => ErrorAnnouncementsWidget(errorMessage: err.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOldDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(child: Divider(color: DesignConstants.secondaryTextColor, thickness: 2)),
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
          Expanded(child: Divider(color: DesignConstants.secondaryTextColor, thickness: 2)),
        ],
      ),
    );
  }
}