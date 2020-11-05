part of 'repository.dart';

class BugRepository with DaoProviderMixin, RepositoryProviderMixin {
  Future<void> fetchBugs() async {
    var bugs = await GetBugs().execute();

    for (var bug in bugs) await bugDao.insert(bug);
  }

  Future<void> downloadBugImage(Bug bug) async {
    return;

    if (!await fileRepository.exists(bug.imagePath))
      bug.imagePath = await fileRepository.downloadImage(bug.imageUri);

    if (!await fileRepository.exists(bug.iconPath))
      bug.iconPath = await fileRepository.downloadImage(bug.iconUri);

    await updateBug(bug);
  }

  Future<Tuple2<List<Bug>, List<bool>>> getBugs() async {
    var bugs = await bugDao.findAll();
    var condition = await this.condition;
    var setting = await settingRepository.setting;

    var isVisibles = bugs
        .map(
          (bug) => condition.apply(
            bug,
            modules.clock.now,
            setting.language ?? LanguageEnum.USen,
          ),
        )
        .toList();

    return Tuple2(bugs, isVisibles);
  }

  Future<void> updateBug(Bug bug) async => bugDao.update(bug.id, bug);

  Future<BugFilterCondition> get condition async {
    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.bugFilterCondition];
    if (value != null) return BugFilterCondition.fromJson(json.decode(value));
    var condition = BugFilterCondition();
    await setCondition(condition);

    return condition;
  }

  Future<void> setCondition(BugFilterCondition condition) async {
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.bugFilterCondition] =
        json.encode(condition.toJson());
  }
}
