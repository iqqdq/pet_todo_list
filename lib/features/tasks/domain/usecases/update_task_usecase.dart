import 'package:todo_list_app/features/tasks/domain/entities/entities.dart';
import 'package:todo_list_app/features/tasks/domain/repository/repository.dart';

class UpdateTaskUsecase {
  UpdateTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  final TasksRepository _repository;

  Future<TaskEntity> call({
    required String deskId,
    required TaskEntity task,
  }) async {
    final tasks = await _repository.getTasks(deskId: deskId);

    if (tasks == null) {
      await _repository.updateTasks(deskId: deskId, tasks: [task]);
      return task;
    } else {
      await _repository.updateTasks(deskId: deskId, tasks: tasks..add(task));
      return task;
    }
  }
}
