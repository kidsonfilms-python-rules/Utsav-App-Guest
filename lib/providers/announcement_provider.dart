import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsav_app/models/announcement_model.dart';

// 1. The Provider Definition
final announcementsProvider = AsyncNotifierProvider<AnnouncementsNotifier, List<Announcement>>(() {
  return AnnouncementsNotifier();
});

// 2. The Notifier Logic
class AnnouncementsNotifier extends AsyncNotifier<List<Announcement>> {
  
  // This replaces the old constructor/init logic. 
  // It is called automatically when the provider is first read/watched.
  @override
  FutureOr<List<Announcement>> build() async {
    return _fetchDummyAnnouncements();
  }

  // Separated fetch logic for reuse in refresh()
  Future<List<Announcement>> _fetchDummyAnnouncements() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network

    return [
      Announcement(
        date: DateTime.now().subtract(const Duration(hours: 2)),
        message: "Dinner is **currently** being served",
        tags: ["URGENT", "SCHEDULE"],
        isRead: false,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 1)),
        message: "Come see the really new [artists](https://utsavsac.org) performing tonight!",
        tags: ["PROMO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "This is a really long announcement about someone *not* parking right!",
        tags: ["INFO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "Lunch is ~~currently~~ being served",
        tags: ["INFO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(hours: 2)),
        message: "Dinner is **currently** being served",
        tags: ["URGENT", "SCHEDULE"],
        isRead: false,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 1)),
        message: "Come see the really new [artists](https://utsavsac.org) performing tonight!",
        tags: ["PROMO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "This is a really long announcement about someone *not* parking right!",
        tags: ["INFO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "Lunch is ~~currently~~ being served",
        tags: ["INFO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(hours: 2)),
        message: "Dinner is **currently** being served",
        tags: ["URGENT", "SCHEDULE"],
        isRead: false,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 1)),
        message: "Come see the really new [artists](https://utsavsac.org) performing tonight!",
        tags: ["PROMO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "This is a really long announcement about someone *not* parking right!",
        tags: ["INFO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "Lunch is ~~currently~~ being served",
        tags: ["INFO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(hours: 2)),
        message: "Dinner is **currently** being served",
        tags: ["URGENT", "SCHEDULE"],
        isRead: false,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 1)),
        message: "Come see the really new [artists](https://utsavsac.org) performing tonight!",
        tags: ["PROMO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "This is a really long announcement about someone *not* parking right!",
        tags: ["INFO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "Lunch is ~~currently~~ being served",
        tags: ["INFO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(hours: 2)),
        message: "Dinner is **currently** being served",
        tags: ["URGENT", "SCHEDULE"],
        isRead: false,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 1)),
        message: "Come see the really new [artists](https://utsavsac.org) performing tonight!",
        tags: ["PROMO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "This is a really long announcement about someone *not* parking right!",
        tags: ["INFO"],
        isRead: true,
      ),
      Announcement(
        date: DateTime.now().subtract(const Duration(days: 2)),
        message: "Lunch is ~~currently~~ being served",
        tags: ["INFO"],
        isRead: true,
      ),      
    ];
  }

  // Mark a specific announcement as read
  Future<void> markAsRead(int index) async {
    // We check state.value. If it's null (loading/error), we can't update anything.
    final currentList = state.value;
    if (currentList == null) return;

    // Create a new list references to trigger a UI rebuild
    final updatedList = List<Announcement>.from(currentList);
    
    // Update the specific item safely using copyWith
    updatedList[index] = updatedList[index].copyWith(isRead: true);

    // Set the new state. usage of AsyncData keeps the UI in the 'data' state.
    state = AsyncData(updatedList);
  }

  // Force a refresh from the "server"
  Future<void> refresh() async {
    // 1. Set state to loading to trigger your Skeleton/Loading UI
    state = const AsyncLoading();
    
    // 2. Use AsyncValue.guard to handle try/catch logic automatically
    state = await AsyncValue.guard(() => _fetchDummyAnnouncements());
  }
}