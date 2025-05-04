import 'dart:convert';

import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

class DeskLocalStorage {
  final SharedPreferencesStorage<String> _localStorage;
  static const _desksKey = 'desks';

  DeskLocalStorage(this._localStorage);

  Future<List<DeskEntity>?> getDesks() async {
    final json = await _localStorage.get(_desksKey);
    final list = json == null ? null : jsonDecode(json) as List<dynamic>;
    return list?.map((e) => DeskEntity.fromJson(e)).toList();
  }

  Future saveDesks(List<DeskEntity> desks) async => _localStorage.save(
    _desksKey,
    jsonEncode(desks.map((desks) => desks.toJson()).toList()),
  );

  Future deleteDesk(String id) async => _localStorage.delete(id);
}
