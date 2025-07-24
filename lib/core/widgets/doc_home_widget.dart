import 'package:flutter/material.dart';
import 'package:multas_app/features/documents/domain/entities/task.dart';
import 'package:multas_app/features/home/presentation/links_page.dart';

class DocHomeWidget extends StatelessWidget {
  const DocHomeWidget({required this.task, super.key});
  final Task task;

  @override
  Widget build(BuildContext context) => InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, ),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => BrowserPage(
                    //   url: "https://instaflutter.com",
                    // ),
                    builder: (context) => const SpacedItemsList(),
                  ),
                );
              },
              child: const Text('Consultar'),
            ),
            leading: const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 24,
            ),
          ),
        ),
      );
}
