import 'package:todo_list_app/features/tasks/domain/entities/entities.dart';
import 'package:todo_list_app/features/tasks/domain/repository/repository.dart';

class UpdateTaskUsecase {
  UpdateTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  final TasksRepository _repository;

  Future<TaskEntity?> call({
    required String deskId,
    required TaskEntity task,
  }) async => await _repository.updateTask(deskId: deskId, task: task);
}
