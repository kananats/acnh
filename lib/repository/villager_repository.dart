part of 'repository.dart';

class VillagerRepository with DaoProviderMixin, RepositoryProviderMixin {
  Future<List<Tuple2<Villager, bool>>> fetchVillagers() async {
    List<Villager> villagers = await GetVillagers().execute();

    if (villagers.isEmpty) throw NoVillagerError();

    for (var villager in villagers) await villagerDao.insert(villager);

    return await findVillagers();
  }

  Future<List<Tuple2<Villager, bool>>> findVillagers() async {
    await _deleteVillagerImagesIfNeeded();

    var villagers = await villagerDao.findAll();
    if (villagers.isEmpty) throw NoVillagerError();

    var condition = await this.condition;
    var setting = await settingRepository.setting;

    return villagers
        .map(
          (e) => Tuple2(
            e,
            condition.apply(
              e,
              setting.language,
            ),
          ),
        )
        .toList();
  }

  Future<void> updateVillager(Villager villager) async =>
      villagerDao.update(villager.id, villager);

  Future<VillagerFilterCondition> get condition async {
    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.villagerFilterCondition];
    if (value != null)
      return VillagerFilterCondition.fromJson(json.decode(value));

    var condition = VillagerFilterCondition();
    await setCondition(condition);

    return condition;
  }

  Future<void> setCondition(VillagerFilterCondition condition) async {
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.villagerFilterCondition] =
        json.encode(condition.toJson());
  }

  Future<void> downloadVillagerImages() async {
    var tuples = await findVillagers();
    var villagers = tuples.map((e) => e.item1).toList();

    for (int index = 0; index < villagers.length; index++) {
      var villager = villagers[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(villager.imagePath)) {
        villager.imagePath =
            await fileRepository.downloadImage(villager.imageUri);
        shouldUpdate = true;
      }

      if (!await fileRepository.exists(villager.iconPath)) {
        villager.iconPath =
            await fileRepository.downloadImage(villager.iconUri);
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateVillager(villager);
    }
  }

  Future<void> _deleteVillagerImagesIfNeeded() async {
    var villagers = await villagerDao.findAll();

    for (int index = 0; index < villagers.length; index++) {
      var villager = villagers[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(villager.imagePath)) {
        villager.imagePath = null;
        shouldUpdate = true;
      }

      if (!await fileRepository.exists(villager.iconPath)) {
        villager.iconPath = null;
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateVillager(villager);
    }
  }
}
