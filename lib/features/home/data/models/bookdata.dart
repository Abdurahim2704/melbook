import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'audio.dart';
import 'category.dart';

class BookData extends Equatable {
  final String id;
  final String name;
  final String photoUrl;
  final String description;
  final String author;
  final int price;
  final Category category;
  String? bookUrl;
  final String createdAt;
  final String updatedAt;
  final int v;
  final bool bought;
  List<Audio>? audios;

  BookData({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.author,
    required this.price,
    required this.category,
    required this.bookUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.bought,
    required this.audios,
  });

  factory BookData.fromJson(Map<String, Object?> json) {
    print(json["audios"]);
    final id = json['_id'] as String;
    final name = json['name'] as String;
    final photoUrl = json['photo_url'] as String;
    final description = json['description'] as String;
    final author = json['author'] as String;
    final price = json['price'] as int;
    final category =
        Category.fromJson(json['category'] as Map<String, Object?>);
    final bookUrl = json['book_url'] as String?;
    final createdAt = json['createdAt'] as String;
    final updatedAt = json['updatedAt'] as String;
    final v = json['__v'] as int;
    final bought = json['bought'] as bool;
    final audios = (json['audios'] as List<dynamic>?)
        ?.map((e) => Audio.fromJson(e as Map<String, Object?>))
        .toList();

    return BookData(
      id: id,
      name: name,
      photoUrl: photoUrl,
      description: description,
      author: author,
      price: price,
      category: category,
      bookUrl: bookUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
      bought: bought,
      audios: audios,
    );
  }

  String toJson() {
    return jsonEncode({
      '_id': id,
      'name': name,
      'photo_url': photoUrl,
      'description': description,
      'author': author,
      'price': price,
      'category': category.toJson(),
      'book_url': bookUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'bought': bought,
      'audios': audios?.map((e) => e.toJson()).toList(),
    });
  }

  @override
  List<Object?> get props => [id];
}
