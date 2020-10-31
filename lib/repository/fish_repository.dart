import 'package:acnh/dao/dao.dart';
import 'package:acnh/data/get_fishs.dart';
import 'package:acnh/repository/repository.dart';
import 'package:acnh/dto/fish.dart';

class FishRepository with DaoProviderMixin, RepositoryProviderMixin {
  Future<void> fetchFishs() async {
    var fishs = await GetFishs().execute();

    for (var fish in fishs) await fishDao.insert(fish);
  }

  Future<void> downloadFishImage(Fish fish) async {
    return;

    if (!await fileRepository.exists(fish.imagePath))
      fish.imagePath = await fileRepository.downloadImage(fish.imageUri);

    if (!await fileRepository.exists(fish.iconPath))
      fish.iconPath = await fileRepository.downloadImage(fish.iconUri);

    await updateFish(fish);
  }

  Future<List<Fish>> getFishs() async => fishDao.findAll();

  Future<void> updateFish(Fish fish) async => fishDao.update(fish.id, fish);
}
