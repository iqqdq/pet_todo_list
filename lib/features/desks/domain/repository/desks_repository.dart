import 'package:todo_list_app/features/desks/domain/entities/entities.dart';

abstract interface class DesksRepository {
  Future<List<DeskEntity>?> getDesks({required String userId});
  Future<DeskEntity?> addDesk({
    required String userId,
    required DeskEntity desk,
  });
  Future<DeskEntity?> updateDesk({
    required String userId,
    required DeskEntity desk,
  });
  Future deleteDesk({required String userId, required String id});
}
