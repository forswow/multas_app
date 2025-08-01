import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationShell extends StatelessWidget {
  const BottomNavigationShell({required this.navigationShell, super.key});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: navigationShell,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: NavigationEnum.values
              .map(
                (el) => BottomNavigationBarItem(
                  icon: Icon(el.icon),
                  label: el.label,
                ),
              )
              .toList(),
          currentIndex: navigationShell.currentIndex,
          selectedItemColor: Colors.blue[800],
          onTap: navigationShell.goBranch,
        ),
      );
}

enum NavigationEnum {
  multas(Icons.receipt_long, 'Multas'),
  documents(Icons.folder, 'Documentos'),
  mas(Icons.grid_view, 'Más');

  const NavigationEnum(this.icon, this.label);
  final IconData icon;
  final String label;
}
