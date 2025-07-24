import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multas_app/core/app/router/router.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp.router(
        title: 'Multas',
        routerConfig: router,
        theme: false
            ? ThemeData.dark(
                useMaterial3: false,
              )
            : ThemeData.light(
                useMaterial3: false,
              ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
