import 'package:todo_list_app/features/tasks/domain/entities/entities.dart';
import 'package:todo_list_app/features/tasks/domain/repository/repository.dart';

class AddTaskUsecase {
  AddTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  final TasksRepository _repository;

  Future<TaskEntity?> call({
    required String deskId,
    required String name,
  }) async {
    final task = TaskEntity(id: DateTime.now().toString(), name: name);
    final tasks = await _repository.getTasks(deskId: deskId);

    if (tasks == null) {
      await _repository.updateTasks(deskId: deskId, tasks: [task]);
      return task;
    } else {
      final exists = tasks.any((element) => element.name == task.name);
      if (exists) return null;

      await _repository.updateTasks(deskId: deskId, tasks: tasks..add(task));
      return task;
    }
  }
}
