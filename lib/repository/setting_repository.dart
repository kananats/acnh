import 'dart:async';
import 'dart:convert';
import 'package:acnh/module.dart';
import 'package:acnh/data/preferences.dart';
import 'package:acnh/dto/language_enum.dart';
import 'package:acnh/dto/settings.dart';

class SettingRepository {
  Setting cachedSetting;

  Future<Setting> get setting async {
    if (cachedSetting != null) return cachedSetting;

    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.setting];
    if (value != null) {
      cachedSetting = Setting.fromJson(json.decode(value));
    } else {
      cachedSetting = Setting()..language = LanguageEnum.USen;
      await setSetting(cachedSetting);
    }
    return cachedSetting;
  }

  Future<void> setSetting(Setting setting) async {
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.setting] = json.encode(setting.toJson());
  }
}
