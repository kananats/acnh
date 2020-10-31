import 'package:acnh/data/get_fishs.dart';
import 'package:acnh/module.dart';
import 'package:acnh/ui/fish/fish.dart';
import 'package:sqflite/sqlite_api.dart';

class FishRepository with DaoProviderMixin {
  Future<void> fetchFishs() async {
    return;

    var db = await modules.localStorage.db;
    var fishs = await GetFishs().execute();

    for (var fish in fishs) {
      await db.insert(
        "fishs",
        fish.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> downloadFishImage(Fish fish) async {
    print(fish.imagePath);

    if (!await modules.fileRepository.exists(fish.imagePath))
      fish.imagePath =
          await modules.fileRepository.downloadImage(fish.imageUri);

    if (!await modules.fileRepository.exists(fish.iconPath))
      fish.iconPath = await modules.fileRepository.downloadImage(fish.iconUri);

    await updateFish(fish);
  }

  Future<List<Fish>> getFishs() async => fishDao.findAll();

  Future<void> updateFish(Fish fish) async {
    var db = await modules.localStorage.db;
    await db.update(
      "fishs",
      fish.toMap(),
      where: "id = ?",
      whereArgs: [fish.id],
    );
  }
}
