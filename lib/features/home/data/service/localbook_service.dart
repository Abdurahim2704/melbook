import 'package:melbook/features/home/data/models/local_book.dart';
import 'package:melbook/features/home/data/service/file_service.dart';
import 'package:sqflite/sqflite.dart';

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
    final books = await getBooks();
    if (books.contains(book)) {
      return;
    }
    await dbClient.insert(
      'books',
      book.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all LocalBooks from the database
  Future<List<LocalBook>> getBooks() async {
    var dbClient = await db;
    final List<Map<String, Object?>> maps = await dbClient.query('books');
    // final List<Map<String, Object?>> data = jsonDecode(jsonEncode(maps));
    final books = maps.map((e) => LocalBook.fromJson(e)).toList();
    return books;
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
  Future<void> deleteBook(LocalBook? book) async {
    var dbClient = await db;
    if (book == null) {
      return;
    }
    LocalService().deleteFile(book.audios.map((e) => e.location).toList());

    await dbClient.execute('DROP TABLE IF EXISTS books');
  }
}
