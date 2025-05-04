import 'package:todo_list_app/features/tasks/domain/entities/entities.dart';
import 'package:todo_list_app/features/tasks/domain/repository/repository.dart';

class GetTasksUsecase {
  GetTasksUsecase({required TasksRepository repository})
    : _repository = repository;

  final TasksRepository _repository;

  Future<List<TaskEntity>?> call({required String deskId}) async =>
      await _repository.getTasks(deskId: deskId);
}
