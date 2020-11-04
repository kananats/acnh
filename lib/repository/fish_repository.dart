part of 'repository.dart';

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

  Future<Tuple2<List<Fish>, List<bool>>> getFishs() async {
    var fishs = await fishDao.findAll();
    var condition = await this.condition;
    var setting = await settingRepository.setting;

    var isVisibles = fishs
        .map(
          (fish) => condition.apply(
            fish,
            modules.clock.now,
            setting.language ?? LanguageEnum.USen,
          ),
        )
        .toList();

    return Tuple2(fishs, isVisibles);
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
}
