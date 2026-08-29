import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:utsav_app/models/scheduled_event_model.dart';
import 'package:utsav_app/providers/supabase_provider.dart';

class EventsNotifier extends StreamNotifier<List<ScheduledEvent>> {
  Timer? _timer;

  @override
  Stream<List<ScheduledEvent>> build() {
    _startStatusTimer();
    ref.onDispose(() => _timer?.cancel());
    return ref
        .read(supabaseProvider)
        .from('scheduled_events')
        .stream(primaryKey: ['id'])
        .order('starts_at')
        .map(
          (rows) => rows.map(ScheduledEvent.fromJson).toList(growable: false),
        );
  }

  void _startStatusTimer() {
    _timer?.cancel();
    final now = DateTime.now();
    final delay = Duration(
      seconds: 60 - now.second,
      milliseconds: -now.millisecond,
    );
    Timer(delay, () {
      _updateNowStatus();
      _timer = Timer.periodic(
        const Duration(minutes: 1),
        (_) => _updateNowStatus(),
      );
    });
  }

  void _updateNowStatus() {
    final events = state.value;
    if (events == null) return;
    final now = DateTime.now();
    state = AsyncData(
      events
          .map((event) => event.copyWith(isNow: _checkIfNow(event, now)))
          .toList(growable: false),
    );
  }

  bool _checkIfNow(ScheduledEvent event, DateTime now) {
    try {
      return !now.isBefore(_startTime(event, now.year)) &&
          now.isBefore(_endTime(event, now.year));
    } catch (_) {
      return false;
    }
  }

  ScheduledEvent? getEventByTitle(String title) {
    for (final event in state.value ?? <ScheduledEvent>[]) {
      if (event.title == title) return event;
    }
    return null;
  }

  List<ScheduledEvent> queryEvents({String? location, String? searchQuery}) {
    return (state.value ?? []).where((event) {
      return (location == null || event.location == location) &&
          (searchQuery == null ||
              event.title.toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();
  }

  ScheduledEvent? getActiveOrNextEventAt(String location) {
    final events =
        (state.value ?? []).where((event) => event.location == location).toList();
    final now = DateTime.now();
    events.sort(
      (a, b) => _startTime(a, now.year).compareTo(_startTime(b, now.year)),
    );
    for (final event in events) {
      if (now.isBefore(_endTime(event, now.year))) return event;
    }
    return null;
  }

  DateTime _startTime(ScheduledEvent event, int year) =>
      _eventTime(event.day, event.time, year);

  DateTime _endTime(ScheduledEvent event, int year) =>
      _eventTime(event.day, event.endTime, year);

  DateTime _eventTime(String day, String time, int year) =>
      DateFormat('yyyy/MM/dd h:mm a').parse('$year/${day.split(' ')[1]} $time');

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final eventsProvider =
    StreamNotifierProvider<EventsNotifier, List<ScheduledEvent>>(
      EventsNotifier.new,
    );
