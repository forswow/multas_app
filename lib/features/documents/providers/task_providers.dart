import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multas_app/core/providers/database_provider.dart';
import 'package:multas_app/features/documents/data/repositories/task_repository_impl.dart';
import 'package:multas_app/features/documents/domain/entities/task.dart';
import 'package:multas_app/features/documents/domain/repositories/task_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_providers.g.dart';

@riverpod
TaskRepository taskRepository(Ref ref) {
  final database = ref.watch(databaseProvider).requireValue;
  return TaskRepositoryImpl(database);
}

@riverpod
class TasksNotifier extends _$TasksNotifier {
  @override
  Future<List<Task>> build() async {
    final repository = ref.watch(taskRepositoryProvider);
    return repository.getTasks();
  }

  Future<void> addTask(Task task) async {
    final repository = ref.watch(taskRepositoryProvider);
    await repository.insertTask(task);
    ref.invalidateSelf();
  }

  Future<void> updateTask(Task task) async {
    final repository = ref.watch(taskRepositoryProvider);
    await repository.updateTask(task);
    ref.invalidateSelf();
  }

  Future<void> deleteTask(int id) async {
    final repository = ref.watch(taskRepositoryProvider);
    await repository.deleteTask(id);
    ref.invalidateSelf();
  }
}

@riverpod
List<Task> vehicleTasks(Ref ref) {
  final tasks = ref.watch(tasksNotifierProvider);
  return tasks.when(
    data: (taskList) =>
        taskList.where((task) => task.description == 'Patente').toList(),
    loading: () => [],
    error: (_, __) => [],
  );
}
