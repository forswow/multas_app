import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/database_provider.dart';
import '../data/repositories/task_repository_impl.dart';
import '../domain/entities/task.dart';
import '../domain/repositories/task_repository.dart';

part 'task_providers.g.dart';

@riverpod
TaskRepository taskRepository(TaskRepositoryRef ref) {
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
List<Task> vehicleTasks(VehicleTasksRef ref) {
  final tasks = ref.watch(tasksNotifierProvider);
  return tasks.when(
    data: (taskList) =>
        taskList.where((task) => task.description == 'Patente').toList(),
    loading: () => [],
    error: (_, __) => [],
  );
}
