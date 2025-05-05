import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/desks/desks.dart';
import 'package:todo_list_app/features/tasks/tasks.dart';

final sl = DIContainer();

Future<void> initInjections() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();

  // Data sources
  final sharedPreferencesStorage = SharedPreferencesStorage<String>(
    sharedPreferences,
  );
  final deskLocalStorage = DeskLocalStorage(sharedPreferencesStorage);
  final taskLocalStorage = TaskLocalStorage(sharedPreferencesStorage);

  // Repositories
  final desksRepository = DesksRepositoryImpl(localStorage: deskLocalStorage);
  final tasksRepositoryImpl = TasksRepositoryImpl(
    localStorage: taskLocalStorage,
  );

  // Desk usecases
  sl.registerLazySingleton(
    (container) => GetDesksUsecase(repository: desksRepository),
  );
  sl.registerLazySingleton(
    (container) => AddDeskUsecase(repository: desksRepository),
  );
  sl.registerLazySingleton(
    (container) => DeleteDeskUsecase(repository: desksRepository),
  );
  sl.registerLazySingleton(
    (container) => UpdateDeskUsecase(repository: desksRepository),
  );

  // Task usecases
  sl.registerLazySingleton(
    (container) => GetTasksUsecase(repository: tasksRepositoryImpl),
  );
  sl.registerLazySingleton(
    (container) => AddTaskUsecase(repository: tasksRepositoryImpl),
  );
  sl.registerLazySingleton(
    (container) => DeleteTaskUsecase(repository: tasksRepositoryImpl),
  );
  sl.registerLazySingleton(
    (container) => UpdateTaskUsecase(repository: tasksRepositoryImpl),
  );
  sl.registerLazySingleton(
    (container) => SetTaskStatusUsecase(repository: tasksRepositoryImpl),
  );
}
