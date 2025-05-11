import 'package:todo_list_app/features/tasks/domain/repository/repository.dart';

class DeleteTaskUsecase {
  DeleteTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  final TasksRepository _repository;

  Future call({required String deskId, required String id}) async =>
      await _repository.deleteTask(deskId: deskId, id: id);
}
