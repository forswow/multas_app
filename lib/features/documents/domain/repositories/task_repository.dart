import 'package:multas_app/features/documents/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> insertTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
}
