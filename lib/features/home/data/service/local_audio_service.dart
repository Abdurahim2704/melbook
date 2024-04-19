import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalAudioService {
  static Database? _database;
  static const String _tableName = 'audios';

  static Future<void> initDb() async {
    if (_database != null) return;
    try {
      String path = join(await getDatabasesPath(), 'audio_database.db');
      _database =
          await openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $_tableName('
          'name TEXT, location TEXT, book TEXT)',
        );
      });
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  // Add a new audio record
  static Future<void> saveAudio(
      String name, String location, String book) async {
    await initDb();
    final isExists = await getAudioByName(name);
    print(isExists);
    if (isExists.map((e) => e.book).contains(book)) {
      return;
    }
    print("I am insert2");
    await _database?.insert(
      _tableName,
      {'name': name, 'location': location, 'book': book},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("men insertman");
  }

  static Future<List<LocalAudio>> getAudios() async {
    await initDb();
    final result = await _database!.query(_tableName);
    final audios = result
        .map((e) => LocalAudio.fromSql(e as Map<String, dynamic>))
        .toList();
    return audios;
  }

  static Future<List<LocalAudio>> getAudioByName(String name) async {
    await initDb();
    final result = await _database!.query(
      _tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
    final audios = result
        .map((e) => LocalAudio.fromSql(e as Map<String, dynamic>))
        .toList();
    return audios;
  }
}

class LocalAudio {
  final String name;
  final String location;
  final String book;

  const LocalAudio({
    required this.name,
    required this.location,
    required this.book,
  });

  factory LocalAudio.fromSql(Map<String, dynamic> json) {
    final name = json["name"] as String;
    final location = json["location"] as String;
    final book = json["book"] as String;

    return LocalAudio(name: name, location: location, book: book);
  }

  @override
  String toString() {
    return jsonEncode({"name": name, "location": location});
  }
}
