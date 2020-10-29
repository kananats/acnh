import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class LocalStorage {
  Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;

    // Uncomment this to delete database
    // await deleteDatabase();

    await _createDatabase();
    return _db;
  }

  Future<void> deleteDatabase() => databaseFactory.deleteDatabase("acnh.db");

  Future<void> _createDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    _db = await openDatabase(
      join(await getDatabasesPath(), "acnh.db"),
      onCreate: (db, version) => db.execute(
        "CREATE TABLE fishes(id INTEGER PRIMARY KEY, name TEXT, image_uri TEXT, icon_uri TEXT)",
      ),
      version: 1,
    );

    // Uncomment this to log
    // print(await _db.query("fishes"));
  }
}
