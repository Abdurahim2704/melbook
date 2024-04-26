import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
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
          'name TEXT, location TEXT, book TEXT, description TEXT)',
        );
      });
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  // Add a new audio record
  static Future<void> saveAudio(
      String name, String location, String book, String description) async {
    await initDb();
    final isExists = await getAudioByName(name);
    if (isExists.map((e) => e.book).contains(book)) {
      return;
    }
    await _database?.insert(
      _tableName,
      {
        'name': name,
        'location': location,
        'book': book,
        "description": description
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

class LocalAudio extends Equatable {
  final String name;
  final String location;
  final String book;
  final List<DialogPairs> description;

  const LocalAudio({
    required this.name,
    required this.location,
    required this.book,
    required this.description,
  });

  factory LocalAudio.fromSql(Map<String, dynamic> json) {
    final name = json["name"] as String;
    final location = json["location"] as String;
    final book = json["book"] as String;
    final description = json["description"] as String;
    final List<DialogPairs> dialogs = [];
    for (int i = 0; i < description.split("\n").length - 1; i += 2) {
      final line = description.split("\n").toList()[i];
      final translation = description.split("\n").toList()[i + 1];
      int points = max(line.length, translation.length) ~/ 30;
      if (points == 0) {
        points = 1;
      }

      dialogs.add(
          DialogPairs(line: line, translation: translation, points: points));
    }

    return LocalAudio(
        name: name, location: location, book: book, description: dialogs);
  }

  int pointCount() {
    return description
        .map((e) => e.points)
        .reduce((value, element) => element + value);
  }

  @override
  List<Object?> get props => [name, location, book];

  @override
  String toString() {
    return jsonEncode({
      "name": name,
      "location": location,
    });
  }
}

class DialogPairs {
  final String line;
  final String translation;
  final int points;

  const DialogPairs(
      {required this.line, required this.translation, required this.points});

  @override
  String toString() {
    return jsonEncode(
        {"line": line, "translation": translation, "points": points});
  }
}
