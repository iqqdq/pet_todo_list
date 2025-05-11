import 'package:todo_list_app/features/auth/domain/domain.dart';

class RegisterUsecase {
  RegisterUsecase({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  Future<UserEntity?> call({
    required String email,
    required String name,
    required String password,
  }) async => await _repository.register(
    user: UserEntity(
      id: DateTime.now().toString(),
      email: email,
      name: name,
      password: password,
    ),
  );
}
