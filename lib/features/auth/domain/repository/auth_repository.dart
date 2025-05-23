import 'package:todo_list_app/features/auth/domain/domain.dart';

abstract interface class AuthRepository {
  Future<bool> checkEmailAvailability({required String email});
  Future register({required UserEntity user});
  Future<UserEntity?> login({required String email, required String password});
  Future logout();
  Future<UserEntity?> getCurrentUser();
}
