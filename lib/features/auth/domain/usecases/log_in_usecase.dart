import 'package:todo_list_app/features/auth/domain/domain.dart';

class LogInUsecase {
  LogInUsecase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  Future<UserEntity?> call({
    required String email,
    required String password,
  }) async => await _repository.login(email: email, password: password);
}
