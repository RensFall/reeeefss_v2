import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> setString({
    required String key,
    required String value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  FutureOr<bool> setBool({
    required String key,
    required bool value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  FutureOr<bool?> getBool({
    required String key,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  FutureOr<String?> getString({
    required String key,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
