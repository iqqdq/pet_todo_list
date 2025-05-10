import 'package:todo_list_app/features/auth/data/data.dart';
import 'package:todo_list_app/features/auth/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalStorage _localStorage;

  AuthRepositoryImpl({required AuthLocalStorage localStorage})
    : _localStorage = localStorage;

  @override
  Future<UserEntity?> login({
    required String email,
    required String password,
  }) async {
    final users = await _localStorage.getUsers();
    final user = users?.firstWhere(
      (element) => element.email == email && element.password == password,
    );
    if (user != null) await _localStorage.saveCurrentUser(user);
    return user;
  }

  @override
  Future register({required UserEntity user}) async =>
      await _localStorage.createUser(user);

  @override
  Future<UserEntity?> getCurrentUser() async =>
      await _localStorage.getCurrentUser();
}
