import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/core/di/di.dart';
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

  // Usecases
  sl.registerLazySingleton(
    (container) => GetCurrentUserUsecase(repository: authRepository),
  );
  sl.registerLazySingleton(
    (container) => RegisterUsecase(repository: authRepository),
  );
  sl.registerLazySingleton(
    (container) => LogInUsecase(repository: authRepository),
  );

  // MARK: -
  // MARK: - HOME

  // Data sources
  final homeLocalStorage = HomeLocalStorage(sharedPreferencesStorage);

  // Repositories
  final homeRepository = HomeRepositoryImpl(localStorage: homeLocalStorage);

  // Usecases
  sl.registerLazySingleton(
    (container) => LogOutUsecase(repository: homeRepository),
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
}
