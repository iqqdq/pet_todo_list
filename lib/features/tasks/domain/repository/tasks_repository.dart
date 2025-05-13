import 'package:todo_list_app/features/tasks/domain/entities/entities.dart';

abstract interface class TasksRepository {
  Future<List<TaskEntity>?> getTasks({required String deskId});
  Future<TaskEntity?> addTask({
    required String deskId,
    required TaskEntity task,
  });
  Future<TaskEntity?> updateTask({
    required String deskId,
    required TaskEntity task,
  });
  Future deleteTask({required String deskId, required String id});
}
