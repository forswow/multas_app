import 'package:multas_app/features/documents/domain/entities/task.dart';
import 'package:multas_app/features/documents/domain/repositories/task_repository.dart';
import 'package:sqflite/sqflite.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl(this.database);
  final Database database;

  @override
  Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await database.query('tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  @override
  Future<void> insertTask(Task task) async {
    await database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTask(Task task) async {
    await database.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<void> deleteTask(int id) async {
    await database.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
