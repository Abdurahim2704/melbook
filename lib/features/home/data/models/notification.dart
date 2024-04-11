import 'dart:convert';

class Notification {
  final String id;
  final String photoUrl;
  final String title;
  final String content;
  final List<String> readBy;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Notification({
    required this.id,
    required this.photoUrl,
    required this.title,
    required this.content,
    required this.readBy,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['_id'] as String,
      photoUrl: json['photo_url'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      readBy: List<String>.from(json['readBy'] as List),
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }

  String toJson() {
    return jsonEncode({
      '_id': id,
      'photo_url': photoUrl,
      'title': title,
      'content': content,
      'readBy': readBy,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    });
  }
}
