part of 'repository.dart';

class SeaRepository
    with DaoProviderMixin, ClockProviderMixin, RepositoryProviderMixin {
  Future<List<Tuple2<Sea, bool>>> fetchSeas() async {
    List<Sea> seas = await GetSeas().execute();

    if (seas.isEmpty) throw NoSeaError();

    for (var sea in seas) await seaDao.insert(sea);

    return await findSeas();
  }

  Future<List<Tuple2<Sea, bool>>> findSeas() async {
    await _deleteSeaImagesIfNeeded();

    var seas = await seaDao.findAll();
    if (seas.isEmpty) throw NoSeaError();

    var condition = await this.condition;
    var setting = await settingRepository.setting;

    return seas
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

  Future<void> updateSea(Sea sea) async => seaDao.update(sea.id, sea);

  Future<SeaFilterCondition> get condition async {
    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.seaFilterCondition];
    if (value != null) return SeaFilterCondition.fromJson(json.decode(value));
    var condition = SeaFilterCondition();
    await setCondition(condition);

    return condition;
  }

  Future<void> setCondition(SeaFilterCondition condition) async {
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.seaFilterCondition] =
        json.encode(condition.toJson());
  }

  Future<void> downloadSeaImages() async {
    var tuples = await findSeas();
    var seas = tuples.map((e) => e.item1).toList();

    for (int index = 0; index < seas.length; index++) {
      var sea = seas[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(sea.imagePath)) {
        sea.imagePath = await fileRepository.downloadImage(sea.imageUri);
        shouldUpdate = true;
      }

      if (!await fileRepository.exists(sea.iconPath)) {
        sea.iconPath = await fileRepository.downloadImage(sea.iconUri);
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateSea(sea);
    }
  }

  Future<void> _deleteSeaImagesIfNeeded() async {
    var seas = await seaDao.findAll();

    for (int index = 0; index < seas.length; index++) {
      var sea = seas[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(sea.imagePath)) {
        sea.imagePath = null;
        shouldUpdate = true;
      }

      if (!await fileRepository.exists(sea.iconPath)) {
        sea.iconPath = null;
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateSea(sea);
    }
  }
}
