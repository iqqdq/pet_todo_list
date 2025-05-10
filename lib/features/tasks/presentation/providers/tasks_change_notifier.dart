import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/tasks/domain/domain.dart';

class TasksChangeNotifier with ChangeNotifier {
  final String _deskId;
  TasksChangeNotifier({required String deskId}) : _deskId = deskId;

  ScreenStateEnum _state = ScreenStateEnum.initial;
  ScreenStateEnum get state => _state;

  final List<TaskEntity> _tasks = [];
  List<TaskEntity> get tasks => _tasks;

  Future getTasks() async {
    final tasks = await sl.get<GetTasksUsecase>().call(deskId: _deskId);
    if (tasks == null) return;
    _tasks.clear();
    _tasks.addAll(tasks);
    _state = ScreenStateEnum.success;
    notifyListeners();
  }

  Future addTask({required String name}) async => await sl
      .get<AddTaskUsecase>()
      .call(deskId: _deskId, name: name)
      .then((value) {
        if (value == null) {
          _state = ScreenStateEnum.error;
          notifyListeners();
        } else {
          getTasks();
        }
      });

  Future deleteTask({required String deskId, required String id}) async {
    await sl.get<DeleteTaskUsecase>().call(deskId: deskId, id: id);
    getTasks();
  }

  Future updateTask({required String deskId, required TaskEntity task}) async {
    await sl.get<UpdateTaskUsecase>().call(deskId: deskId, task: task);
    await getTasks();
  }
}
