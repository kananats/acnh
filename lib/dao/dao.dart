import 'package:acnh/module.dart';

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
