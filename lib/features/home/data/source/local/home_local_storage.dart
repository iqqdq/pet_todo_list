import 'package:todo_list_app/core/core.dart';

class HomeLocalStorage {
  final SharedPreferencesStorage<String> _localStorage;
  static const _currentUserKey = 'current_user';

  HomeLocalStorage(this._localStorage);

  Future deleteCurrentUser() async =>
      await _localStorage.delete(_currentUserKey);
}
