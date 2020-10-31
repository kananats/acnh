import 'package:acnh/module.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

mixin Dao<T> {
  String get tableName;

  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T data);

  Future<List<T>> findAll() async {
    var db = await modules.localStorage.db;
    var maps = await db.query(tableName);

    return List<T>.generate(
      maps.length,
      (index) => fromMap(maps[index]),
    );
  }

  Future<void> update(T data) async {
    var db = await modules.localStorage.db;
    await db.update(
      tableName,
      toMap(data),
    );
  }
}

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
        """
        CREATE TABLE fishs(
          id INTEGER PRIMARY KEY, 
          name TEXT, 
          image_uri TEXT, 
          icon_uri TEXT,
          image_path TEXT,
          icon_path TEXT,
          is_caught INTEGER, 
          is_donated INTEGER
        )
        """,
      ),
      version: 1,
    );

    // Uncomment this to log
    print(await _db.query("fishs"));
  }
}
