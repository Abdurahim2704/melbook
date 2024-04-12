import 'dart:convert';

class BannerModel {
  final String id;
  final String photoUrl;
  final String createdAt;
  final String updatedAt;
  final int v;

  BannerModel({
    required this.id,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    final id = json['_id'] as String;
    final photoUrl = json['photo_url'] as String;
    final createdAt = json['createdAt'] as String;
    final updatedAt = json['updatedAt'] as String;
    final v = json['__v'] as int;

    return BannerModel(
      id: id,
      photoUrl: photoUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }

  String toJson() {
    return jsonEncode({
      '_id': id,
      'photo_url': photoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    });
  }
}
