part of 'repository.dart';

class FishRepository
    with DaoProviderMixin, ClockProviderMixin, RepositoryProviderMixin {
  Future<List<Tuple2<Fish, bool>>> fetchFishs() async {
    List<Fish> fishs = await GetFishs().execute();

    if (fishs.isEmpty) throw NoFishError();

    for (var fish in fishs) await fishDao.insert(fish);

    return await findFishs();
  }

  Future<List<Tuple2<Fish, bool>>> findFishs() async {
    await _deleteFishImagesIfNeeded();

    var fishs = await fishDao.findAll();
    if (fishs.isEmpty) throw NoFishError();

    var condition = await this.condition;
    var setting = await settingRepository.setting;

    return fishs
        .map(
          (e) => Tuple2(
            e,
            condition.apply(
              e,
              clock.now,
              setting.language,
            ),
          ),
        )
        .toList();
  }

  Future<void> updateFish(Fish fish) async => fishDao.update(fish.id, fish);

  Future<FishFilterCondition> get condition async {
    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.fishFilterCondition];
    if (value != null) return FishFilterCondition.fromJson(json.decode(value));
    var condition = FishFilterCondition();
    await setCondition(condition);

    return condition;
  }

  Future<void> setCondition(FishFilterCondition condition) async {
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.fishFilterCondition] =
        json.encode(condition.toJson());
  }

  Future<void> downloadFishImages() async {
    var tuples = await findFishs();
    var fishs = tuples.map((e) => e.item1).toList();

    for (int index = 0; index < fishs.length; index++) {
      var fish = fishs[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(fish.imagePath)) {
        fish.imagePath = await fileRepository.downloadImage(fish.imageUri);
        shouldUpdate = true;
      }

      if (!await fileRepository.exists(fish.iconPath)) {
        fish.iconPath = await fileRepository.downloadImage(fish.iconUri);
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateFish(fish);
    }
  }

  Future<void> _deleteFishImagesIfNeeded() async {
    var fishs = await fishDao.findAll();

    for (int index = 0; index < fishs.length; index++) {
      var fish = fishs[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(fish.imagePath)) {
        fish.imagePath = null;
        shouldUpdate = true;
      }

      if (!await fileRepository.exists(fish.iconPath)) {
        fish.iconPath = null;
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateFish(fish);
    }
  }
}
