import 'package:todo_list_app/features/tasks/domain/entities/entities.dart';
import 'package:todo_list_app/features/tasks/domain/repository/repository.dart';

class AddTaskUsecase {
  AddTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  final TasksRepository _repository;

  Future<TaskEntity?> call({
    required String deskId,
    required String name,
  }) async => await _repository.addTask(
    deskId: deskId,
    task: TaskEntity(id: DateTime.now().toString(), name: name),
  );
}
