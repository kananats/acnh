import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:acnh/data/preferences.dart';
import 'package:acnh/dto/fish_filter_condition.dart';
import 'package:acnh/module.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileRepository {
  Future<String> download(String url) async {
    var directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}/downloads/$url";
    await Dio().download(url, path);
    return path;
  }

  Future<String> downloadImage(String url) async {
    var directory = await getApplicationDocumentsDirectory();
    var imageUrl = url.replaceAll("https://", "downloads/");
    var path = "${directory.path}/$imageUrl.png";
    await Dio().download(url, path);
    return path;
  }

  Future<bool> exists(String path) async {
    if (path == null || path.isEmpty) return false;
    return await File(path).exists();
  }

  Future<FishFilterCondition> getFishFilterCondition() async {
    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.fishFilterCondition];
    if (value == null) {
      var condition = FishFilterCondition();
      await setFishFilterCondition(condition);
      return condition;
    }
    return FishFilterCondition.fromJson(json.decode(value));
  }

  Future<void> setFishFilterCondition(FishFilterCondition condition) async {
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.fishFilterCondition] =
        json.encode(condition.toJson());
  }

  Future<Preferences> get preferences async => modules.localStorage.preferences;
}
