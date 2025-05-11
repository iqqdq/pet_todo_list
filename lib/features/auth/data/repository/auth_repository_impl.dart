import 'package:todo_list_app/features/auth/data/data.dart';
import 'package:todo_list_app/features/auth/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalStorage _localStorage;

  AuthRepositoryImpl({required AuthLocalStorage localStorage})
    : _localStorage = localStorage;

  @override
  Future<UserEntity?> register({required UserEntity user}) async {
    final users = await _localStorage.getUsers();
    if (users != null) {
      final isEmailTaken = users.any((element) => element.email == user.email);
      if (isEmailTaken) return null;
    }
    await _localStorage.createUser(user);
    return user;
  }

  @override
  Future<UserEntity?> login({
    required String email,
    required String password,
  }) async {
    final users = await _localStorage.getUsers();
    if (users != null) {
      final isUserExists = users.any(
        (element) => element.email == email && element.password == password,
      );
      if (isUserExists) {
        final user = users.firstWhere(
          (element) => element.email == email && element.password == password,
        );
        await _localStorage.saveCurrentUser(user);
        return user;
      }
    }
    return null;
  }

  @override
  Future logout() async => await _localStorage.deleteCurrentUser();

  @override
  Future<UserEntity?> getCurrentUser() async =>
      await _localStorage.getCurrentUser();
}
