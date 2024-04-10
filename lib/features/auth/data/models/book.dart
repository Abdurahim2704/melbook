import 'dart:convert';

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

class BookData {
  final String id;
  final String name;
  final String photoUrl;
  final String description;
  final String author;
  final int price;
  final Category category;
  final String bookUrl;
  final String createdAt;
  final String updatedAt;
  final int v;
  final bool bought;
  final List<Audio> audios;

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
    final id = json['_id'] as String;
    final name = json['name'] as String;
    final photoUrl = json['photo_url'] as String;
    final description = json['description'] as String;
    final author = json['author'] as String;
    final price = json['price'] as int;
    final category = Category.fromJson(json['category'] as Map<String, Object?>);
    final bookUrl = json['book_url'] as String;
    final createdAt = json['createdAt'] as String;
    final updatedAt = json['updatedAt'] as String;
    final v = json['__v'] as int;
    final bought = json['bought'] as bool;
    final audios = (json['audios'] as List<dynamic>)
        .map((e) => Audio.fromJson(e as Map<String, Object?>))
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
      'audios': audios.map((e) => e.toJson()).toList(),
    });
  }
}

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
