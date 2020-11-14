part of 'repository.dart';

class FossilRepository
    with DaoProviderMixin, ClockProviderMixin, RepositoryProviderMixin {
  Future<List<Tuple2<Fossil, bool>>> fetchFossils() async {
    List<Fossil> fossils = await GetFossils().execute();

    if (fossils.isEmpty) throw NoFossilError();

    for (var fossil in fossils) await fossilDao.insert(fossil);

    return await findFossils();
  }

  Future<List<Tuple2<Fossil, bool>>> findFossils() async {
    await _deleteFossilImagesIfNeeded();

    var fossils = await fossilDao.findAll();
    if (fossils.isEmpty) throw NoFossilError();

    var condition = await this.condition;
    var setting = await settingRepository.setting;

    return fossils
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

  Future<void> updateFossil(Fossil fossil) async =>
      fossilDao.update(fossil.id, fossil);

  Future<FossilFilterCondition> get condition async {
    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.fossilFilterCondition];
    if (value != null)
      return FossilFilterCondition.fromJson(json.decode(value));
    var condition = FossilFilterCondition();
    await setCondition(condition);

    return condition;
  }

  Future<void> setCondition(FossilFilterCondition condition) async {
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.fossilFilterCondition] =
        json.encode(condition.toJson());
  }

  Future<void> downloadFossilImages() async {
    var tuples = await findFossils();
    var fossils = tuples.map((e) => e.item1).toList();

    for (int index = 0; index < fossils.length; index++) {
      var fossil = fossils[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(fossil.imagePath)) {
        fossil.imagePath = await fileRepository.downloadImage(fossil.imageUri);
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateFossil(fossil);
    }
  }

  Future<void> _deleteFossilImagesIfNeeded() async {
    var fossils = await fossilDao.findAll();

    for (int index = 0; index < fossils.length; index++) {
      var fossil = fossils[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(fossil.imagePath)) {
        fossil.imagePath = null;
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateFossil(fossil);
    }
  }
}
