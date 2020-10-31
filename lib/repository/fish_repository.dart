import 'package:acnh/dao/dao.dart';
import 'package:acnh/data/get_fishs.dart';
import 'package:acnh/module.dart';
import 'package:acnh/ui/fish/fish.dart';

class FishRepository with DaoProviderMixin {
  Future<void> fetchFishs() async {
    var fishs = await GetFishs().execute();

    for (var fish in fishs) await fishDao.insert(fish);
  }

  Future<void> downloadFishImage(Fish fish) async {
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
