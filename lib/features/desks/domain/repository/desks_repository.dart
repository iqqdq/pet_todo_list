import 'package:todo_list_app/features/desks/domain/entities/entities.dart';

abstract interface class DesksRepository {
  Future<List<DeskEntity>?> getDesks();
  Future saveDesks({required List<DeskEntity> desks});
  Future deleteDeskTasks({required String id});
}
