import 'package:todo_list_app/features/desks/data/data.dart';
import 'package:todo_list_app/features/desks/domain/domain.dart';

class DesksRepositoryImpl implements DesksRepository {
  final DeskLocalStorage _localStorage;

  DesksRepositoryImpl({required DeskLocalStorage localStorage})
    : _localStorage = localStorage;

  @override
  Future<List<DeskEntity>?> getDesks({required String userId}) async =>
      await _localStorage.getDesks(userId);

  @override
  Future<DeskEntity?> addDesk({
    required String userId,
    required DeskEntity desk,
  }) async {
    final desks = await _localStorage.getDesks(userId);
    if (desks == null) {
      await _localStorage.saveDesks(userId, [desk]);
    } else {
      final isDeskExists = desks.any((element) => element.name == desk.name);
      if (isDeskExists) {
        return null;
      } else {
        desks.add(desk);
        await _localStorage.saveDesks(userId, desks);
      }
    }
    return desk;
  }

  @override
  Future<DeskEntity> updateDesk({
    required String userId,
    required DeskEntity desk,
  }) async {
    final desks = await _localStorage.getDesks(userId);
    final index = desks!.indexWhere((element) => element.id == desk.id);
    desks[index] = desk;
    await _localStorage.saveDesks(userId, desks);
    return desk;
  }

  @override
  Future deleteDesk({required String userId, required String id}) async {
    final desks = await _localStorage.getDesks(userId);
    final index = desks!.indexWhere((element) => element.id == id);
    desks.removeAt(index);
    await _localStorage.saveDesks(userId, desks);
  }
}
