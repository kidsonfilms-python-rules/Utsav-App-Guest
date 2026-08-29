class Announcement {
  final String id;
  final DateTime date;
  final String message;
  final List<String>? tags;
  final bool isRead;

  Announcement({
    required this.id,
    required this.date,
    required this.message,
    this.tags,
    this.isRead = false,
  });

  // Added copyWith to make state updates cleaner and less error-prone
  Announcement copyWith({
    String? id,
    DateTime? date,
    String? message,
    List<String>? tags,
    bool? isRead,
  }) {
    return Announcement(
      id: id ?? this.id,
      date: date ?? this.date,
      message: message ?? this.message,
      tags: tags ?? this.tags,
      isRead: isRead ?? this.isRead,
    );
  }

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'].toString(),
      date: DateTime.parse(json['published_at'] as String),
      message: json['message'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      // Read state is user-specific and comes from the announcement_reads view.
      isRead: json['is_read'] as bool? ?? false,
    );
  }
}
