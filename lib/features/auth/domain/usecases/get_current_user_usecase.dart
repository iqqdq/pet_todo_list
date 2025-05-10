import 'package:todo_list_app/features/auth/domain/domain.dart';

class GetCurrentUserUsecase {
  GetCurrentUserUsecase({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  Future<UserEntity?> call() async => await _repository.getCurrentUser();
}
