// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class LocalBook {
//   final String name;
//   final String location;
//   final String size;
//
//   LocalBook({required this.name, required this.location, required this.size});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'location': location,
//       'size': size,
//     };
//   }
// }
//
// class LocalBookService {
//   Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await initDb();
//     return _database!;
//   }
//
//   initDb() async {
//     return await openDatabase(
//       join(await getDatabasesPath(), 'local_book.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           "CREATE TABLE books(id INTEGER PRIMARY KEY, name TEXT, location TEXT, size TEXT)",
//         );
//       },
//       version: 1,
//     );
//   }
//
//   Future<void> insertLocalBook(LocalBook book) async {
//     final db = await database;
//     await db.insert('books', book.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<List<LocalBook>> localBooks() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('books');
//
//     return List.generate(maps.length, (i) {
//       return LocalBook(
//         name: maps[i]['name'],
//         location: maps[i]['location'],
//         size: maps[i]['size'],
//       );
//     });
//   }
//
//   Future<LocalBook?> getLocalBookByName(String name) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'books',
//       where: 'name = ?',
//       whereArgs: [name],
//     );
//
//     if (maps.isNotEmpty) {
//       return LocalBook(
//         name: maps[0]['name'],
//         location: maps[0]['location'],
//         size: maps[0]['size'],
//       );
//     }
//     return null;
//   }
//
//   Future<void> deleteLocalBook(String name) async {
//     final db = await database;
//     await db.delete(
//       'books',
//       where: 'name = ?',
//       whereArgs: [name],
//     );
//   }
// }
