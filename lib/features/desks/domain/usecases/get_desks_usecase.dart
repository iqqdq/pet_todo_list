import 'package:todo_list_app/features/desks/domain/entities/entities.dart';
import 'package:todo_list_app/features/desks/domain/repository/repository.dart';

class GetDesksUsecase {
  GetDesksUsecase({required DesksRepository repository})
    : _repository = repository;

  final DesksRepository _repository;

  Future<List<DeskEntity>?> call({required String userId}) async =>
      await _repository.getDesks(userId: userId);
}
