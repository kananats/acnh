part of 'repository.dart';

class ArtRepository
    with DaoProviderMixin, ClockProviderMixin, RepositoryProviderMixin {
  Future<List<Tuple2<Art, bool>>> fetchArts() async {
    List<Art> arts = await GetArts().execute();

    if (arts.isEmpty) throw NoArtError();

    for (var art in arts) await artDao.insert(art);

    return await findArts();
  }

  Future<List<Tuple2<Art, bool>>> findArts() async {
    await _deleteArtImagesIfNeeded();

    var arts = await artDao.findAll();
    if (arts.isEmpty) throw NoArtError();

    var condition = await this.condition;
    var setting = await settingRepository.setting;

    return arts
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

  Future<void> updateArt(Art art) async => artDao.update(art.id, art);

  Future<ArtFilterCondition> get condition async {
    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.artFilterCondition];
    if (value != null) return ArtFilterCondition.fromJson(json.decode(value));
    var condition = ArtFilterCondition();
    await setCondition(condition);

    return condition;
  }

  Future<void> setCondition(ArtFilterCondition condition) async {
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.artFilterCondition] =
        json.encode(condition.toJson());
  }

  Future<void> downloadArtImages() async {
    var tuples = await findArts();
    var arts = tuples.map((e) => e.item1).toList();

    for (int index = 0; index < arts.length; index++) {
      var art = arts[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(art.imagePath)) {
        art.imagePath = await fileRepository.downloadImage(art.imageUri);
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateArt(art);
    }
  }

  Future<void> _deleteArtImagesIfNeeded() async {
    var arts = await artDao.findAll();

    for (int index = 0; index < arts.length; index++) {
      var art = arts[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(art.imagePath)) {
        art.imagePath = null;
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateArt(art);
    }
  }
}
