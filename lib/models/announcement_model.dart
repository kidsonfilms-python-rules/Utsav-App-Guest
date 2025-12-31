class Announcement {
  final DateTime date;
  final String message;
  final List<String>? tags;
  final bool isRead;

  Announcement({
    required this.date,
    required this.message,
    this.tags,
    this.isRead = false,
  });

  // Added copyWith to make state updates cleaner and less error-prone
  Announcement copyWith({
    DateTime? date,
    String? message,
    List<String>? tags,
    bool? isRead,
  }) {
    return Announcement(
      date: date ?? this.date,
      message: message ?? this.message,
      tags: tags ?? this.tags,
      isRead: isRead ?? this.isRead,
    );
  }

  factory Announcement.fromJson(Map<String, Object?> json) {
    return Announcement(
      date: DateTime.parse(json['date']! as String),
      message: json['message']! as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isRead: json['isRead']! as bool,
    );
  }
}