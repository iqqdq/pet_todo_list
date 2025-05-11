import 'dart:convert';

import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/tasks/domain/entities/task_entity.dart';

class TaskLocalStorage {
  final SharedPreferencesStorage<String> _localStorage;

  TaskLocalStorage(this._localStorage);

  Future<List<TaskEntity>?> getTasks(String deskId) async {
    final json = await _localStorage.get(deskId);
    final list = json == null ? null : jsonDecode(json) as List<dynamic>;
    return list?.map((e) => TaskEntity.fromJson(e)).toList();
  }

  Future<List<TaskEntity>> saveTasks(
    String deskId,
    List<TaskEntity> tasks,
  ) async {
    final list = tasks.map((task) => task.toJson()).toList();
    _localStorage.save(deskId, jsonEncode(list));
    return tasks;
  }
}
