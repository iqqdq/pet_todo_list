import 'package:todo_list_app/features/auth/domain/domain.dart';

class EmailAvailabilityUsecase {
  EmailAvailabilityUsecase({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  Future<bool> call({required String email}) async =>
      await _repository.checkEmailAvailability(email: email);
}
