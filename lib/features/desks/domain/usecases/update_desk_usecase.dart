import 'package:todo_list_app/features/desks/domain/entities/entities.dart';
import 'package:todo_list_app/features/desks/domain/repository/repository.dart';

class UpdateDeskUsecase {
  UpdateDeskUsecase({required DesksRepository repository})
    : _repository = repository;

  final DesksRepository _repository;

  Future<DeskEntity> call({required DeskEntity desk}) async {
    var desks = await _repository.getDesks();
    final index = desks!.indexWhere((element) => element.id == desk.id);
    desks[index] = desk;

    await _repository.saveDesks(desks: desks);
    return desk;
  }
}
