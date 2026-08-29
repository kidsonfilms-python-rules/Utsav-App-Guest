import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsav_app/models/announcement_model.dart';
import 'package:utsav_app/providers/supabase_provider.dart';

final announcementsProvider =
    AsyncNotifierProvider<AnnouncementsNotifier, List<Announcement>>(
  AnnouncementsNotifier.new,
);

class AnnouncementsNotifier extends AsyncNotifier<List<Announcement>> {
  @override
  FutureOr<List<Announcement>> build() => _fetchAnnouncements();

  Future<List<Announcement>> _fetchAnnouncements() async {
    // This view joins each announcement with the signed-in user's read state.
    final rows = await ref
        .read(supabaseProvider)
        .from('announcement_feed')
        .select()
        .order('published_at', ascending: false);
    return (rows as List)
        .map(
          (row) => Announcement.fromJson(Map<String, dynamic>.from(row as Map)),
        )
        .toList();
  }

  Future<void> markAsRead(int index) async {
    final current = state.value;
    if (current == null || index < 0 || index >= current.length || current[index].isRead) {
      return;
    }
    final announcement = current[index];
    final client = ref.read(supabaseProvider);
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client.from('announcement_reads').upsert({
      'announcement_id': announcement.id,
      'user_id': userId,
    }, onConflict: 'announcement_id,user_id');

    final updated = List<Announcement>.from(current);
    updated[index] = announcement.copyWith(isRead: true);
    state = AsyncData(updated);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchAnnouncements);
  }
}
