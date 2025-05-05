import 'package:todo_list_app/features/desks/data/data.dart';
import 'package:todo_list_app/features/desks/domain/domain.dart';

class DesksRepositoryImpl implements DesksRepository {
  final DeskLocalStorage _localStorage;

  DesksRepositoryImpl({required DeskLocalStorage localStorage})
    : _localStorage = localStorage;

  @override
  Future<List<DeskEntity>?> getDesks() async => await _localStorage.getDesks();

  @override
  Future saveDesks({required List<DeskEntity> desks}) async =>
      await _localStorage.saveDesks(desks);

  @override
  Future deleteDeskTasks({required String id}) async =>
      await _localStorage.deleteDesk(id);
}
