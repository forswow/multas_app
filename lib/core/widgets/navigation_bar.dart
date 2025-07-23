import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Multas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Documentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Más',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: Colors.blue[800],
        onTap: navigationShell.goBranch,
      ),
    );
  }
}
