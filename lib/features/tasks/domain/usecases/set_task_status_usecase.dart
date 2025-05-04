import 'package:todo_list_app/features/tasks/domain/entities/entities.dart';
import 'package:todo_list_app/features/tasks/domain/repository/repository.dart';

class SetTaskStatusUsecase {
  SetTaskStatusUsecase({required TasksRepository repository})
    : _repository = repository;

  final TasksRepository _repository;

  Future call({required String deskId, required TaskEntity task}) async {
    List<TaskEntity>? tasks = await _repository.getTasks(deskId: deskId);
    final index = tasks!.indexWhere((element) => element.id == task.id);
    tasks[index] = task;

    await _repository.updateTasks(deskId: deskId, tasks: tasks);
  }
}
