part of 'repository.dart';

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
    cachedSetting = setting;
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.setting] = json.encode(setting.toJson());
  }
}
