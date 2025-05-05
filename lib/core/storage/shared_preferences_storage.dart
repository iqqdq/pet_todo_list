import 'package:shared_preferences/shared_preferences.dart';

import 'storage.dart';

class SharedPreferencesStorage<T> implements LocalStorage<T> {
  final SharedPreferences sharedPreferences;

  SharedPreferencesStorage(this.sharedPreferences);

  @override
  Future<void> save(String key, T value) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
    }
  }

  @override
  Future<T?> get(String key) async => sharedPreferences.get(key) as T?;

  @override
  Future<void> delete(String key) async => await sharedPreferences.remove(key);
}
