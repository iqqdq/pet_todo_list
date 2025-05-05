import 'package:todo_list_app/features/tasks/domain/entities/entities.dart';

abstract interface class TasksRepository {
  Future<List<TaskEntity>?> getTasks({required String deskId});
  Future updateTasks({required String deskId, required List<TaskEntity> tasks});
  Future deleteTask({required String deskId, required List<TaskEntity> tasks});
}
