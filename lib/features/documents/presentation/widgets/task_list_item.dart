import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../providers/task_providers.dart';

class TaskListItem extends ConsumerWidget {
  const TaskListItem({required this.task, super.key});
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        leading: Checkbox(
          value: task.isChecked,
          shape: const CircleBorder(),
          activeColor: Colors.green,
          onChanged: (newValue) async {
            final updatedTask = task.copyWith(isChecked: newValue!);
            await ref
                .read(tasksNotifierProvider.notifier)
                .updateTask(updatedTask);
          },
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever_sharp),
          onPressed: () => _showDeleteDialog(context, ref),
        ),
      );

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Borrar documento?'),
        content: Text('¿Seguro que quieres borrar "${task.title}"?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Volver'),
          ),
          TextButton(
            onPressed: () {
              ref.read(tasksNotifierProvider.notifier).deleteTask(task.id!);
              Navigator.of(context).pop();
            },
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
  }
}
