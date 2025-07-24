import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/preferences_provider.dart';
import '../providers/settings_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            themeAsync.when(
              data: (isDark) => SwitchListTile(
                secondary: const Icon(Icons.light_mode),
                title: const Text("Modo oscuro"),
                value: isDark,
                onChanged: (value) {
                  ref.read(themeNotifierProvider.notifier).toggleTheme();
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveTrackColor: Colors.grey.shade300,
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error al cargar configuración'),
            ),
          ],
        ),
      ),
    );
  }
}
