import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../providers/task_providers.dart';

class AddTaskForm extends ConsumerStatefulWidget {
  const AddTaskForm({super.key});

  @override
  ConsumerState<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends ConsumerState<AddTaskForm> {
  final _titleController = TextEditingController();
  bool _isChecked = false;
  String _selectedDescription = 'Patente';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Actualiza tus datos vehículo',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Número de documento',
                prefixIcon: const Icon(Icons.verified_user),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Tipo de documento',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              value: _selectedDescription,
              onChanged: (newValue) {
                setState(() {
                  _selectedDescription = newValue!;
                });
              },
              items: <String>['DNI', 'Patente', 'Licencia de conducir']
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                  .toList(),
            ),
            CheckboxListTile(
              title: const Text('Válido'),
              value: _isChecked,
              checkboxShape: const CircleBorder(),
              activeColor: Colors.green,
              onChanged: (newValue) {
                setState(() {
                  _isChecked = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
              onPressed: _addTask,
              child: const Text(
                "AGREGAR",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      );

  Future<void> _addTask() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final task = Task(
      title: title,
      description: _selectedDescription,
      isChecked: _isChecked,
    );

    await ref.read(tasksNotifierProvider.notifier).addTask(task);

    _titleController.clear();
    setState(() {
      _isChecked = false;
    });
  }
}
