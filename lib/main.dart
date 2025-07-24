import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multas_app/core/app/app.dart';
import 'package:multas_app/core/utils/pref/pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPref.init();
  runApp(const ProviderScope(child: MyApp()));
}
