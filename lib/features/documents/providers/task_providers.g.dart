// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskRepositoryHash() => r'1ea1a19e9075fa19c1686043b361189898c7abd4';

/// See also [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = AutoDisposeProvider<TaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskRepositoryRef = AutoDisposeProviderRef<TaskRepository>;
String _$vehicleTasksHash() => r'1e545dcfc964a3e6ea022c5cba79431f9b4b2615';

/// See also [vehicleTasks].
@ProviderFor(vehicleTasks)
final vehicleTasksProvider = AutoDisposeProvider<List<Task>>.internal(
  vehicleTasks,
  name: r'vehicleTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$vehicleTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VehicleTasksRef = AutoDisposeProviderRef<List<Task>>;
String _$tasksNotifierHash() => r'd6b620d992255bad9a6deffd99a338850a9b2c56';

/// See also [TasksNotifier].
@ProviderFor(TasksNotifier)
final tasksNotifierProvider =
    AutoDisposeAsyncNotifierProvider<TasksNotifier, List<Task>>.internal(
  TasksNotifier.new,
  name: r'tasksNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tasksNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TasksNotifier = AutoDisposeAsyncNotifier<List<Task>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
