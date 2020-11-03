import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences _preferences;

  Preferences(SharedPreferences preferences) {
    this._preferences = preferences;
  }

  operator [](PreferencesKey key) {
    return _preferences.get(key.toString());
  }

  operator []=(PreferencesKey key, value) {
    if (value is bool)
      _preferences.setBool(key.toString(), value);
    else if (value is int)
      _preferences.setInt(key.toString(), value);
    else if (value is double)
      _preferences.setDouble(key.toString(), value);
    else if (value is String)
      _preferences.setString(key.toString(), value);
    else if (value is Map<String, dynamic>)
      _preferences.setString(key.toString(), json.encode(value));
  }
}

enum PreferencesKey {
  setting,
  fishFilterCondition,
}
