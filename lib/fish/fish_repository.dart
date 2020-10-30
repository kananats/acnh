import 'package:acnh/api.dart';
import 'package:acnh/fish/fish.dart';
import 'package:acnh/module.dart';
import 'package:sqflite/sqlite_api.dart';

class FishRepository {
  Future<void> fetch({Function(int count, int total) onReceiveProgress}) async {
    return;

    var db = await modules.localStorage.db;
    var fishes = await GetFish().execute();

    for (int index = 0; index < fishes.length; index++) {
      var fish = fishes[index];

      if (onReceiveProgress != null)
        onReceiveProgress(index + 1, fishes.length);

      fish.imageUri = await modules.fileManager.downloadImage(fish.imageUri);
      fish.iconUri = await modules.fileManager.downloadImage(fish.iconUri);

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

  Future<int> updateFish(Fish fish) async {
    var db = await modules.localStorage.db;
    return await db.update(
      "fishes",
      fish.toMap(),
      where: "id = ?",
      whereArgs: [fish.id],
    );
  }
}
