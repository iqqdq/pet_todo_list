import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

final sl = DIContainer();

Future<void> initInjections() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  final sharedPreferencesStorage = SharedPreferencesStorage<String>(
    sharedPreferences,
  );

  // MARK: -
  // MARK: - AUTH

  // Data sources
  final authLocalStorage = AuthLocalStorage(sharedPreferencesStorage);

  // Repositories
  final authRepository = AuthRepositoryImpl(localStorage: authLocalStorage);
  sl.registerLazySingleton<AuthRepository>((container) => authRepository);

  // Usecases
  sl.registerLazySingleton(
    (container) =>
        EmailAvailabilityUsecase(repository: sl.get<AuthRepository>()),
  );
  sl.registerLazySingleton(
    (container) => RegisterUsecase(repository: sl.get<AuthRepository>()),
  );
  sl.registerLazySingleton(
    (container) => LogInUsecase(repository: sl.get<AuthRepository>()),
  );
  sl.registerLazySingleton(
    (container) => GetCurrentUserUsecase(repository: sl.get<AuthRepository>()),
  );

  // MARK: -
  // MARK: - DESK

  // Data sources
  final deskLocalStorage = DeskLocalStorage(sharedPreferencesStorage);

  // Repositories
  final desksRepository = DesksRepositoryImpl(localStorage: deskLocalStorage);

  // Usecases
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

  // MARK: -
  // MARK: - TASK'S

  // Data sources
  final taskLocalStorage = TaskLocalStorage(sharedPreferencesStorage);

  // Repositories
  final taskRepository = TasksRepositoryImpl(localStorage: taskLocalStorage);

  // Usecases
  sl.registerLazySingleton(
    (container) => GetTasksUsecase(repository: taskRepository),
  );
  sl.registerLazySingleton(
    (container) => AddTaskUsecase(repository: taskRepository),
  );
  sl.registerLazySingleton(
    (container) => DeleteTaskUsecase(repository: taskRepository),
  );
  sl.registerLazySingleton(
    (container) => UpdateTaskUsecase(repository: taskRepository),
  );
}
