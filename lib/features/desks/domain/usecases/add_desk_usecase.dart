import 'package:todo_list_app/features/desks/domain/entities/entities.dart';
import 'package:todo_list_app/features/desks/domain/repository/repository.dart';

class AddDeskUsecase {
  AddDeskUsecase({required DesksRepository repository})
    : _repository = repository;

  final DesksRepository _repository;

  Future<DeskEntity?> call({required String name}) async {
    var desks = await _repository.getDesks();
    final desk = DeskEntity(id: DateTime.now().toString(), name: name);

    if (desks == null) {
      desks = [desk];
      await _repository.saveDesks(desks: desks);
    } else {
      if (desks.any((desk) => desk.name == name)) {
        return null;
      } else {
        desks.add(desk);
        await _repository.saveDesks(desks: desks);
      }
    }

    return desk;
  }
}
