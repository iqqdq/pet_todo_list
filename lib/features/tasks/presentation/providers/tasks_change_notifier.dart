import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/tasks/domain/domain.dart';

class TasksChangeNotifier with ChangeNotifier {
  TasksChangeNotifier({required String deskId}) : _deskId = deskId;

  final String _deskId;

  final List<TaskEntity> _tasks = [];
  List<TaskEntity> get tasks => _tasks;

  String? _error;
  String? get error => _error;

  Future getTasks() async {
    final tasks = await sl.get<GetTasksUsecase>().call(deskId: _deskId);
    if (tasks == null) return;
    _tasks.clear();
    _tasks.addAll(tasks);
    notifyListeners();
  }

  Future addTask({required String name}) async {
    final task = await sl.get<AddTaskUsecase>().call(
      deskId: _deskId,
      name: name,
    );

    if (task == null) {
      _error = AppTitles.taskWithOwnNameExistsYet;
      notifyListeners();
    } else {
      await getTasks();
    }
  }

  Future deleteTask({required String deskId, required String id}) async {
    await sl.get<DeleteTaskUsecase>().call(deskId: deskId, id: id);
    getTasks();
  }

  Future updateTask({required String deskId, required TaskEntity task}) async {
    await sl.get<UpdateTaskUsecase>().call(deskId: deskId, task: task);
    await getTasks();
  }
}
