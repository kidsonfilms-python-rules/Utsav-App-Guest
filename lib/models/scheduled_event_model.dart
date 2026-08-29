class ScheduledEvent {
  final String day;
  final int dayIndex;
  final String title;
  final String time; // This is the Start Time
  final String endTime; // Add this
  final String location;
  final String description;
  final bool isNow;

  ScheduledEvent({
    required this.day,
    required this.dayIndex,
    required this.title,
    required this.time,
    required this.endTime,
    required this.location,
    required this.description,
    this.isNow = false,
  });

  ScheduledEvent copyWith({
    String? day,
    int? dayIndex,
    String? title,
    String? time,
    String? endTime,
    String? location,
    String? description,
    bool? isNow,
  }) {
    return ScheduledEvent(
      day: day ?? this.day,
      dayIndex: dayIndex ?? this.dayIndex,
      title: title ?? this.title,
      time: time ?? this.time,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      description: description ?? this.description,
      isNow: isNow ?? this.isNow,
    );
  }

  factory ScheduledEvent.fromJson(Map<String, dynamic> json) {
    final startsAt = DateTime.parse(json['starts_at'] as String).toLocal();
    final endsAt = DateTime.parse(json['ends_at'] as String).toLocal();
    return ScheduledEvent(
      day:
          '${_dayName(startsAt.weekday)} ${_twoDigits(startsAt.month)}/${_twoDigits(startsAt.day)}',
      dayIndex: json['day_index'] as int,
      title: json['title'] as String,
      time: _time(startsAt),
      endTime: _time(endsAt),
      location: json['location'] as String,
      description: json['description'] as String? ?? '',
      isNow: startsAt.isBefore(DateTime.now()) && endsAt.isAfter(DateTime.now()),
    );
  }

  static String _dayName(int weekday) => const [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ][weekday - 1];

  static String _twoDigits(int value) => value.toString().padLeft(2, '0');

  static String _time(DateTime value) {
    final hour = value.hourOfPeriod == 0 ? 12 : value.hourOfPeriod;
    return '$hour:${_twoDigits(value.minute)} ${value.hour < 12 ? 'AM' : 'PM'}';
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'dayIndex': dayIndex,
      'title': title,
      'time': time,
      'endTime': endTime,
      'location': location,
      'description': description,
      'isNow': isNow,
    };
  }
}
