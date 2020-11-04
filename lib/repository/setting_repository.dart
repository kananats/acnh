part of 'repository.dart';

class SettingRepository {
  Future<Setting> get setting async {
    var preferences = await modules.localStorage.preferences;
    var value = preferences[PreferencesKey.setting];
    if (value != null) return Setting.fromJson(json.decode(value));

    var setting = Setting();
    await setSetting(setting);

    return setting;
  }

  Future<void> setSetting(Setting setting) async {
    var preferences = await modules.localStorage.preferences;
    preferences[PreferencesKey.setting] = json.encode(setting.toJson());
  }
}
