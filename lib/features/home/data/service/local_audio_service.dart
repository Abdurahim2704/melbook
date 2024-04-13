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
    if (isExists.map((e) => e["book"]).contains(book)) {
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

  static Future<List<Map<String, dynamic>>> getAudios() async {
    await initDb();
    return await _database!.query(_tableName);
  }

  static Future<List<Map<String, dynamic>>> getAudioByName(String name) async {
    await initDb();
    return await _database!.query(
      _tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}
