import 'package:todo_list_app/features/tasks/data/data.dart';
import 'package:todo_list_app/features/tasks/domain/domain.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TaskLocalStorage _localStorage;

  TasksRepositoryImpl({required TaskLocalStorage localStorage})
    : _localStorage = localStorage;

  @override
  Future<List<TaskEntity>?> getTasks({required String deskId}) async =>
      await _localStorage.getTasks(deskId);

  @override
  Future updateTasks({
    required String deskId,
    required List<TaskEntity> tasks,
  }) async => await _localStorage.updateTasks(deskId, tasks);

  @override
  Future deleteTask({
    required String deskId,
    required List<TaskEntity> tasks,
  }) async => await _localStorage.updateTasks(deskId, tasks);
}
