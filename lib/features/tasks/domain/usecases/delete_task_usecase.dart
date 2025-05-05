import 'package:todo_list_app/features/tasks/domain/repository/repository.dart';

class DeleteTaskUsecase {
  DeleteTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  final TasksRepository _repository;

  Future call({required String deskId, required String id}) async {
    final tasks = await _repository.getTasks(deskId: deskId);

    if (tasks == null) {
      await _repository.deleteTask(deskId: deskId, tasks: []);
    } else {
      tasks.removeWhere((element) => element.id == id);
      await _repository.deleteTask(deskId: deskId, tasks: tasks);
    }
  }
}
