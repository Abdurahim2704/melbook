import 'dart:convert';

class Audio {
  final String id;
  final String name;
  final String audioUrl;
  final String bookId;
  final String createdAt;
  final String updatedAt;
  final int v;

  Audio({
    required this.id,
    required this.name,
    required this.audioUrl,
    required this.bookId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Audio.fromJson(Map<String, Object?> json) {
    final id = json['_id'] as String;
    final name = json['name'] as String;
    final audioUrl = json['audio_url'] as String;
    final bookId = json['book_id'] as String;
    final createdAt = json['createdAt'] as String;
    final updatedAt = json['updatedAt'] as String;
    final v = json['__v'] as int;

    return Audio(
      id: id,
      name: name,
      audioUrl: audioUrl,
      bookId: bookId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }

  String toJson() {
    return jsonEncode({
      '_id': id,
      'name': name,
      'audio_url': audioUrl,
      'book_id': bookId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    });
  }
}
