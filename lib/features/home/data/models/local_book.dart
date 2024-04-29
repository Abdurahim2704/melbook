import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../service/local_audio_service.dart';

class LocalBook {
  final String name;
  final List<LocalAudio> audios;
  final String description;
  final String author;

  const LocalBook({
    required this.name,
    required this.audios,
    required this.description,
    required this.author,
  });

  // Convert a LocalBook into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toJson() => {
        'name': name,
        'audios': jsonEncode(audios.map((audio) => audio.toSql()).toList()),
        'description': description,
        'author': author,
      };

  // Convert a Map into a LocalBook. The Map must contain all the keys as returned by toJson.
  factory LocalBook.fromJson(Map<String, dynamic> json) => LocalBook(
        name: json['name'],
        audios: (jsonDecode(json['audios']) as List)
            .map((audioJson) => LocalAudio.fromSql(audioJson))
            .toList(),
        description: json['description'],
        author: json['author'],
      );
}

class SqfliteService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    // Initialize the database at a given path
    var databasesPath = await getDatabasesPath();
    String path = '${databasesPath}localbooks.db';
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    // Create the database table
    await db.execute('''
    CREATE TABLE books(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      audios TEXT,
      description TEXT,
      author TEXT
    )
    ''');
  }

  // Insert a LocalBook into the database
  Future<void> insertBook(LocalBook book) async {
    var dbClient = await db;
    await dbClient.insert(
      'books',
      book.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all LocalBooks from the database
  Future<List<LocalBook>> getBooks() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('books');
    return List.generate(maps.length, (i) {
      return LocalBook.fromJson(maps[i]);
    });
  }

  // Update a LocalBook in the database
  Future<void> updateBook(LocalBook book) async {
    var dbClient = await db;
    await dbClient.update(
      'books',
      book.toJson(),
      where: 'name = ?',
      whereArgs: [book.name],
    );
  }

  // Delete a LocalBook from the database
  Future<void> deleteBook(String name) async {
    var dbClient = await db;
    await dbClient.delete(
      'books',
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}
