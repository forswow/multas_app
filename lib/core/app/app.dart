import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multas_app/core/app/router/router.dart';

import 'package:multas_app/core/providers/preferences_provider.dart';

class MultasApp extends ConsumerWidget {
  const MultasApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeAsync = ref.watch(themeNotifierProvider);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp.router(
        title: 'Multas',
        routerConfig: router,
        theme: themeAsync.when(
          data: (isDark) => isDark
              ? ThemeData.dark(useMaterial3: false)
              : ThemeData.light(useMaterial3: false),
          loading: () => ThemeData.light(useMaterial3: false),
          error: (_, __) => ThemeData.light(useMaterial3: false),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
