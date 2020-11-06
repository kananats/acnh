part of 'repository.dart';

class BugRepository
    with DaoProviderMixin, ClockProviderMixin, RepositoryProviderMixin {
  Future<List<Tuple2<Bug, bool>>> fetchBugs() async {
    List<Bug> bugs = await GetBugs().execute();

    if (bugs.isEmpty) throw NoBugError();

    for (var bug in bugs) await bugDao.insert(bug);

    return await findBugs();
  }

  Future<List<Tuple2<Bug, bool>>> findBugs() async {
    await _deleteBugImagesIfNeeded();

    var bugs = await bugDao.findAll();
    if (bugs.isEmpty) throw NoBugError();

    var condition = await this.condition;
    var setting = await settingRepository.setting;

    return bugs
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

  Future<void> downloadBugImages() async {
    var tuples = await findBugs();
    var bugs = tuples.map((e) => e.item1).toList();

    for (int index = 0; index < bugs.length; index++) {
      var bug = bugs[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(bug.imagePath)) {
        bug.imagePath = await fileRepository.downloadImage(bug.imageUri);
        shouldUpdate = true;
      }

      if (!await fileRepository.exists(bug.iconPath)) {
        bug.iconPath = await fileRepository.downloadImage(bug.iconUri);
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateBug(bug);
    }
  }

  Future<void> _deleteBugImagesIfNeeded() async {
    var bugs = await bugDao.findAll();

    for (int index = 0; index < bugs.length; index++) {
      var bug = bugs[index];

      var shouldUpdate = false;
      if (!await fileRepository.exists(bug.imagePath)) {
        bug.imagePath = null;
        shouldUpdate = true;
      }

      if (!await fileRepository.exists(bug.iconPath)) {
        bug.iconPath = null;
        shouldUpdate = true;
      }

      if (shouldUpdate) await updateBug(bug);
    }
  }
}
