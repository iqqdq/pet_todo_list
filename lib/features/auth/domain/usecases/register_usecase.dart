import 'package:todo_list_app/features/auth/domain/domain.dart';

class RegisterUsecase {
  RegisterUsecase({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  Future<UserEntity?> call({
    required String email,
    required String name,
    required String password,
  }) async {
    final user = await _repository.login(email: email, password: password);
    if (user == null) {
      final user = UserEntity(
        email: email,
        name: name,
        password: password,
        token: DateTime.now().toString(),
      );
      await _repository.register(user: user);
      return user;
    } else {
      return null;
    }
  }
}
