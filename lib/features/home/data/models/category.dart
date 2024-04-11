import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final int v;

  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Category.fromJson(Map<String, Object?> json) {
    final id = json['_id'] as String;
    final name = json['name'] as String;
    final createdAt = json['createdAt'] as String;
    final updatedAt = json['updatedAt'] as String;
    final v = json['__v'] as int;

    return Category(
      id: id,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }

  String toJson() {
    return jsonEncode({
      '_id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    });
  }
}
