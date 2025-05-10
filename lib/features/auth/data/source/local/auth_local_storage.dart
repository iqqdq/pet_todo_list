import 'dart:convert';

import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

class AuthLocalStorage {
  final SharedPreferencesStorage<String> _localStorage;
  static const _usersKey = 'users';
  static const _currentUserKey = 'current_user';

  AuthLocalStorage(this._localStorage);

  Future saveCurrentUser(UserEntity user) async =>
      await _localStorage.save(_currentUserKey, jsonEncode(user.toJson()));

  Future<UserEntity?> getCurrentUser() async {
    final json = await _localStorage.get(_currentUserKey);
    return json == null ? null : UserEntity.fromJson(jsonDecode(json));
  }

  Future createUser(UserEntity user) async {
    List<UserEntity>? users = await getUsers();
    users == null ? users = [user] : users.add(user);
    await _localStorage.save(
      _usersKey,
      jsonEncode(users.map((element) => element.toJson()).toList()),
    );
    await saveCurrentUser(user);
  }

  Future<List<UserEntity>?> getUsers() async {
    final json = await _localStorage.get(_usersKey);
    final list = json == null ? null : jsonDecode(json) as List<dynamic>;
    return list?.map((e) => UserEntity.fromJson(e)).toList();
  }
}
