import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multas_app/features/documents/presentation/widgets/add_task_form.dart';
import 'package:multas_app/features/documents/presentation/widgets/task_list_item.dart';
import 'package:multas_app/features/documents/providers/task_providers.dart';

class DocumentsView extends ConsumerWidget {
  const DocumentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos'),
      ),
      body: Column(
        children: [
          const AddTaskForm(),
          Expanded(
            child: tasksAsync.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text('No tienes ningún documento'),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) =>
                      TaskListItem(task: tasks[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
