import 'package:flutter/material.dart';
import 'package:multas_app/core/services/database_helper.dart';
import 'package:multas_app/features/documents/domain/entities/task.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final TextEditingController _titleController = TextEditingController();
  bool _isChecked = false;
  String _selectedDescription = 'Patente'; // Значение по умолчанию
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Documentos'),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Actualiza tus datos vehículo',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Número de documento',
                  prefixIcon: const Icon(Icons.verified_user),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: DropdownButtonFormField<String>(
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
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 20),
              child: OutlinedButton(
                style:
                    OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
                onPressed: () async {
                  final String title = _titleController.text;
                  final String description = _selectedDescription;
                  final bool isChecked = _isChecked;
                  if (title.isEmpty || description.isEmpty) {
                    return;
                  }
                  dbHelper.insertTask(title, description, isChecked);
                  _titleController.clear();
                  setState(() {
                    _isChecked = false;
                  });
                },
                child: Text(
                  "Agregar".toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Task>>(
                future: dbHelper.getTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No tienes ningún documentos'));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final task = snapshot.data![index];
                        return ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.description),
                          leading: Checkbox(
                            value: task.isChecked,
                            shape: const CircleBorder(),
                            activeColor: Colors.green,
                            onChanged: (newValue) {},
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_forever_sharp),
                            onPressed: () {
                              _showDeleteConfirmationDialog(task);
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );

  void _showDeleteConfirmationDialog(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Borrar documento?'),
        content: Text('¿Seguro que quieres borrar "${task.title}"?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Закрыть диалог
            },
            child: const Text('Volver'),
          ),
          TextButton(
            onPressed: () {
              _deleteTask(task);
              Navigator.of(context).pop(); // Закрыть диалог
            },
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
  }

  void _deleteTask(Task task) async {
    await dbHelper.deleteTask(task.id!);
    setState(() {});
  }
}
