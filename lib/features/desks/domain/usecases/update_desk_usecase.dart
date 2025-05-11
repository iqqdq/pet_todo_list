import 'package:todo_list_app/features/desks/domain/entities/entities.dart';
import 'package:todo_list_app/features/desks/domain/repository/repository.dart';

class UpdateDeskUsecase {
  UpdateDeskUsecase({required DesksRepository repository})
    : _repository = repository;

  final DesksRepository _repository;

  Future<DeskEntity> call({
    required String userId,
    required DeskEntity desk,
  }) async => await _repository.updateDesk(userId: userId, desk: desk);
}
