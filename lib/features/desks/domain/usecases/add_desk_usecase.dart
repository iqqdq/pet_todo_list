import 'package:todo_list_app/features/desks/domain/entities/entities.dart';
import 'package:todo_list_app/features/desks/domain/repository/repository.dart';

class AddDeskUsecase {
  AddDeskUsecase({required DesksRepository repository})
    : _repository = repository;

  final DesksRepository _repository;

  Future<DeskEntity?> call({
    required String userId,
    required String name,
  }) async => await _repository.addDesk(
    userId: userId,
    desk: DeskEntity(id: DateTime.now().toString(), name: name),
  );
}
