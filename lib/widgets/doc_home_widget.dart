import 'package:flutter/material.dart';
import 'package:multas_app/models/doc_model.dart';
import 'package:multas_app/pages/links_page.dart';

class DocHomeWidget extends StatelessWidget {
  final Task task;
  const DocHomeWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
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
}
