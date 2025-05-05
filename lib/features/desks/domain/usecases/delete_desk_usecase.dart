import 'package:todo_list_app/features/desks/domain/domain.dart';

class DeleteDeskUsecase {
  DeleteDeskUsecase({required DesksRepository repository})
    : _repository = repository;

  final DesksRepository _repository;

  Future call({required List<DeskEntity> desks, required String id}) async {
    await _repository.deleteDeskTasks(id: id);
    await _repository.saveDesks(desks: desks);
  }
}
