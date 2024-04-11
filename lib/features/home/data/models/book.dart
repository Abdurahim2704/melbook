import 'dart:convert';

import 'bookdata.dart';

class Book {
  final String message;
  final int status;
  final List<BookData> data;

  Book({
    required this.message,
    required this.status,
    required this.data,
  });

  factory Book.fromJson(Map<String, Object?> json) {
    final message = json['message'] as String;
    final status = json['status'] as int;
    final data = (json['data'] as List<dynamic>)
        .map((e) => BookData.fromJson(e as Map<String, Object?>))
        .toList();

    return Book(
      message: message,
      status: status,
      data: data,
    );
  }

  String toJson() {
    return jsonEncode({
      'message': message,
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
    });
  }
}
