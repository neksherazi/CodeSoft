import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'fav_quotes.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE favs (id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT, author TEXT)');
  }

  static Future<int> insertData(String author) async {
    final db = await _openDatabase();
    final data = {
      'author': author,
    };
    return await db.insert('favs', data);
  }

  static Future<int> deleteData(int id) async {
    final db = await _openDatabase();
    return await db.delete('favs', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await _openDatabase();
    return await db.query('favs');
  }
}
