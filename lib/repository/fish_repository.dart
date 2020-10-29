import 'package:acnh/api/api.dart';
import 'package:acnh/data/fish.dart';
import 'package:acnh/module.dart';
import 'package:sqflite/sqlite_api.dart';

class FishRepository {
  Future<void> fetch() async {
    //return;
    var db = await modules.localStorage.db;
    var fishes = await GetFish().execute();

    for (var fish in fishes) {
      await db.insert(
        "fishes",
        fish.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Fish>> getFishes() async {
    var db = await modules.localStorage.db;
    var maps = await db.query("fishes");

    return List.generate(
      maps.length,
      (index) => Fish.fromMap(maps[index]),
    );
  }
}
