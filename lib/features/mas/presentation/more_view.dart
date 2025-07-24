import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: const Text('Ayuda y Configuración'),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () => context.push('/settings'),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Compartir'),
              onTap: () {
                Share.share(
                    'https://play.google.com/store/search?q=pub%3ADivTag&c=apps');
              },
            ),
            ListTile(
              leading: const Icon(Icons.android_rounded),
              title: const Text('Política de privacidad'),
              onTap: () => context.push('/privacy'),
            ),
          ],
        ),
      );
}
