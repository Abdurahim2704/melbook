import 'dart:convert';

import 'package:equatable/equatable.dart';

class Audio extends Equatable {
  final String id;
  final String name;
  final String audioUrl;
  final String bookId;
  final String createdAt;
  final String updatedAt;
  final String content;
  final int v;

  Audio({
    required this.id,
    required this.name,
    required this.audioUrl,
    required this.bookId,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
    required this.v,
  });

  factory Audio.fromJson(Map<String, Object?> json) {
    final id = json['_id'] as String;
    final name = json['name'] as String;
    final audioUrl = json['audio_url'] as String;
    final bookId = json['book_id'] as String;
    final createdAt = json['createdAt'] as String;
    final updatedAt = json['updatedAt'] as String;
    final content = json["audio_content"] as String;
    final v = json['__v'] as int;

    return Audio(
        id: id,
        name: name,
        audioUrl: audioUrl,
        bookId: bookId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v,
        content: content);
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
      "audio_content": content,
    });
  }

  @override
  String toString() {
    return jsonEncode({
      "name": name,
    });
  }

  @override
  List<Object?> get props => [id, name, audioUrl, content];
}
