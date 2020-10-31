import 'package:acnh/dao/fish_dao.dart';
import 'package:acnh/module.dart';
import 'package:sqflite/sqlite_api.dart';

mixin DaoProviderMixin {
  FishDao get fishDao => modules.fishDao;
}

mixin Dao<T> {
  String get tableName;

  List<String> get ignoredProps => [];

  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T t);

  Future<void> insert(T t) async {
    var db = await modules.localStorage.db;
    var map = toMap(t);
    var entry = await findById(map["id"]);

    if (entry != null) {
      var foundMap = toMap(entry);
      for (var prop in ignoredProps) map[prop] = foundMap[prop];
    }

    await db.insert(
      tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<T>> findAll() async {
    var db = await modules.localStorage.db;
    var maps = await db.query(tableName);

    return List<T>.generate(
      maps.length,
      (index) => fromMap(maps[index]),
    );
  }

  Future<T> findById(int id) async {
    if (id == null) return null;
    var db = await modules.localStorage.db;
    var maps =
        await db.query(tableName, where: "id = ?", whereArgs: [id], limit: 1);
    if (maps.isEmpty) return null;

    return fromMap(maps.first);
  }

  Future<void> update(T t) async {
    var db = await modules.localStorage.db;
    await db.update(
      tableName,
      toMap(t),
    );
  }
}