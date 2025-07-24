import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multas_app/features/documents/domain/entities/task.dart';

class VehicleCard extends ConsumerWidget {
  const VehicleCard({required this.task, super.key});
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
        child: ListTile(
          title: Text(
            task.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          subtitle: Text(
            task.description,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
            onPressed: () => context.push('/consulta'),
            child: const Text('Consultar'),
          ),
          leading: const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 24,
          ),
        ),
      );
}
