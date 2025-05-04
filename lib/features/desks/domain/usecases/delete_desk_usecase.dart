import 'package:todo_list_app/features/desks/domain/repository/repository.dart';

class DeleteDeskUsecase {
  DeleteDeskUsecase({required DesksRepository repository})
    : _repository = repository;

  final DesksRepository _repository;

  Future call({required String id}) async =>
      await _repository.deleteDesk(id: id);
}
