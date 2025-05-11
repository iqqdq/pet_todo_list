import 'package:todo_list_app/features/desks/domain/domain.dart';

class DeleteDeskUsecase {
  DeleteDeskUsecase({required DesksRepository repository})
    : _repository = repository;

  final DesksRepository _repository;

  Future call({required String userId, required String id}) async =>
      await _repository.deleteDesk(userId: userId, id: id);
}
