import 'package:acnh/data/preferences.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class LocalStorage {
  Database _db;

  Future<Preferences> get preferences async =>
      Preferences(await SharedPreferences.getInstance());

  Future<Database> get db async {
    WidgetsFlutterBinding.ensureInitialized();

    if (_db != null) return _db;

    // Uncomment this to delete database
    // await deleteDatabase();

    await _createDatabase();
    return _db;
  }

  Future<void> deleteDatabase() => databaseFactory.deleteDatabase("acnh.db");

  Future<void> _createDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), "acnh.db"),
      onCreate: (db, version) async {
        await _createFishsTable(db);
        await _createBugsTable(db);
        await _createSeasTable(db);
        await _createVillagersTable(db);
        await _createFossilsTable(db);
        await _createArtsTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        switch (oldVersion + 1) {
          case 2:
            await _createBugsTable(db);
            continue version_3;
          version_3:
          case 3:
            await _createSeasTable(db);
            continue version_4;
          version_4:
          case 4:
            await _createVillagersTable(db);
            continue version_5;
          version_5:
          case 5:
            await _createFossilsTable(db);
            continue version_6;
          version_6:
          case 6:
            await _createArtsTable(db);
        }
      },
      version: 6,
    );
  }

  Future<void> _createFishsTable(Database db) async => await db.execute(
        """
CREATE TABLE fishs(
  id INTEGER PRIMARY KEY, 
  file_name TEXT,
  name TEXT,
  availability TEXT,
  shadow TEXT,
  price INTEGER,
  catch_phrase TEXT,
  museum_phrase TEXT,
  image_uri TEXT,
  icon_uri TEXT,
  image_path TEXT,
  icon_path TEXT,
  is_caught INTEGER,
  is_donated INTEGER
)
      """,
      );

  Future<void> _createBugsTable(Database db) async => await db.execute(
        """
CREATE TABLE bugs(
  id INTEGER PRIMARY KEY, 
  file_name TEXT,
  name TEXT,
  availability TEXT,
  price INTEGER,
  catch_phrase TEXT,
  museum_phrase TEXT,
  image_uri TEXT,
  icon_uri TEXT,
  image_path TEXT,
  icon_path TEXT,
  is_caught INTEGER,
  is_donated INTEGER
)
      """,
      );

  Future<void> _createSeasTable(Database db) async => await db.execute(
        """
CREATE TABLE seas(
  id INTEGER PRIMARY KEY, 
  file_name TEXT,
  name TEXT,
  availability TEXT,
  speed TEXT,
  shadow TEXT,
  price INTEGER,
  catch_phrase TEXT,
  museum_phrase TEXT,
  image_uri TEXT,
  icon_uri TEXT,
  image_path TEXT,
  icon_path TEXT,
  is_caught INTEGER,
  is_donated INTEGER
)
      """,
      );

  Future<void> _createVillagersTable(Database db) async => await db.execute(
        """
CREATE TABLE villagers(
  id INTEGER PRIMARY KEY, 
  file_name TEXT,
  name TEXT,
  personality TEXT,
  birthday TEXT,
  species TEXT,
  gender TEXT,
  catch_phrase TEXT,
  image_uri TEXT,
  icon_uri TEXT,
  image_path TEXT,
  icon_path TEXT,
  is_resident INTEGER,
  is_favorite INTEGER
)
      """,
      );

  Future<void> _createFossilsTable(Database db) async => await db.execute(
        """
CREATE TABLE fossils(
  id INTEGER PRIMARY KEY, 
  file_name TEXT,
  name TEXT,
  price INTEGER,
  museum_phrase TEXT,
  image_uri TEXT,
  image_path TEXT,
  is_donated INTEGER
)
      """,
      );

  Future<void> _createArtsTable(Database db) async => await db.execute(
        """
CREATE TABLE arts(
  id INTEGER PRIMARY KEY, 
  file_name TEXT,
  name TEXT,
  has_fake INTEGER,
  buy_price INTEGER,
  sell_price INTEGER,
  image_uri TEXT,
  image_path TEXT,
  museum_desc TEXT,
  is_donated INTEGER
)
      """,
      );
}
