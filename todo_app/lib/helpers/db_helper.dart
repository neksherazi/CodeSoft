import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo_tasks.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)');
  }

  static Future<int> insertData(String title, String description) async {
    final db = await _openDatabase();
    final data = {
      'title': title,
      'description': description,
    };
    return await db.insert('tasks', data);
  }

  static Future<int> updateData(int id, Map<String, dynamic> data) async {
    final db = await _openDatabase();
    return await db.update('tasks', data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteData(int id) async {
    final db = await _openDatabase();
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  static Future<Map<String, dynamic>?> getSingleData(int id) async {
    final db = await _openDatabase();
    List<Map<String, dynamic>> result =
        await db.query('tasks', where: 'id = ?', whereArgs: [id], limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await _openDatabase();
    return await db.query('tasks');
  }
}
