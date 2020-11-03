import 'package:acnh/dao/dao.dart';
import 'package:acnh/data/get_fishs.dart';
import 'package:acnh/data/preferences.dart';
import 'package:acnh/dto/language_enum.dart';
import 'package:acnh/module.dart';
import 'package:acnh/repository/repository.dart';
import 'package:acnh/dto/fish.dart';
import 'dart:async';
import 'dart:convert';

import 'package:acnh/dto/fish_filter_condition.dart';
import 'package:tuple/tuple.dart';

class FishRepository with DaoProviderMixin, RepositoryProviderMixin {
  FishFilterCondition cachedCondition;

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
            setting.freezedDateTime,
            settingRepository.cachedSetting?.language ?? LanguageEnum.USen,
          ),
        )
        .toList();

    return Tuple2(fishs, isVisibles);
  }

  Future<void> updateFish(Fish fish) async => fishDao.update(fish.id, fish);

  Future<FishFilterCondition> get condition async {
    if (cachedCondition != null) return cachedCondition;

    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.fishFilterCondition];
    if (value != null) {
      cachedCondition = FishFilterCondition.fromJson(json.decode(value));
    } else {
      cachedCondition = FishFilterCondition();
      await setCondition(cachedCondition);
    }
    return cachedCondition;
  }

  Future<void> setCondition(FishFilterCondition condition) async {
    cachedCondition = condition;
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.fishFilterCondition] =
        json.encode(condition.toJson());
  }
}
