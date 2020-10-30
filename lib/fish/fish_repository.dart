import 'package:acnh/api.dart';
import 'package:acnh/fish/fish.dart';
import 'package:acnh/module.dart';
import 'package:sqflite/sqlite_api.dart';

class FishRepository {
  Future<void> fetch() async {
    var db = await modules.localStorage.db;
    var fishes = await GetFish().execute();

    for (var fish in fishes) {
      fish.imageUri = await modules.fileManager.download(fish.imageUri);
      fish.iconUri = await modules.fileManager.download(fish.iconUri);

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
