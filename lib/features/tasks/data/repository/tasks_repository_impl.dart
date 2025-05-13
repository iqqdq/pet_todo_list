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
  Future<TaskEntity?> addTask({
    required String deskId,
    required TaskEntity task,
  }) async {
    final tasks = await _localStorage.getTasks(deskId);

    if (tasks == null) {
      await _localStorage.saveTasks(deskId, [task]);
    } else {
      final isTaskExists = tasks.any(
        (element) => element.name.toLowerCase() == task.name.toLowerCase(),
      );

      if (isTaskExists) {
        return null;
      } else {
        tasks.add(task);
        await _localStorage.saveTasks(deskId, tasks);
        return task;
      }
    }

    return null;
  }

  @override
  Future<TaskEntity?> updateTask({
    required String deskId,
    required TaskEntity task,
  }) async {
    final tasks = await _localStorage.getTasks(deskId);
    final index = tasks!.indexWhere((element) => element.id == task.id);

    if (task.status != tasks[index].status) {
      tasks[index] = task;
      await _localStorage.saveTasks(deskId, tasks);
      return task;
    }

    final isTaskExists = tasks.any(
      (element) => element.name.toLowerCase() == task.name.toLowerCase(),
    );

    if (isTaskExists) {
      return null;
    } else {
      tasks[index] = task;
      await _localStorage.saveTasks(deskId, tasks);
      return task;
    }
  }

  @override
  Future deleteTask({required String deskId, required String id}) async {
    final tasks = await _localStorage.getTasks(deskId);
    final index = tasks!.indexWhere((element) => element.id == id);
    tasks.removeAt(index);
    await _localStorage.saveTasks(deskId, tasks);
  }
}
