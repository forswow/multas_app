import 'package:path/path.dart';
import 'package:multas_app/models/doc_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> get database async {
    return openDatabase(
      join(await getDatabasesPath(), 'task_db.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, isChecked INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(
      String title, String description, bool isChecked) async {
    final Database db = await database;
    await db.insert(
      'tasks',
      {
        'title': title,
        'description': description,
        'isChecked': isChecked ? 1 : 0
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getTasks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
