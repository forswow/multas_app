import 'package:sqflite/sqflite.dart';
import '../../../../core/providers/database_provider.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final Database database;

  TaskRepositoryImpl(this.database);

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
