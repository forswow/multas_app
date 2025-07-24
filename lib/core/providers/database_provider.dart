import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Database> database(Ref ref) async => openDatabase(
      join(await getDatabasesPath(), 'multas_db.db'),
      onCreate: (db, version) => db.execute(
        "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, isChecked INTEGER)",
      ),
      version: 1,
    );
