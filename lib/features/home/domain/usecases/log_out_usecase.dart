import 'package:todo_list_app/features/home/domain/domain.dart';

class LogOutUsecase {
  LogOutUsecase({required HomeRepository repository})
    : _repository = repository;

  final HomeRepository _repository;

  Future call() async => await _repository.logout();
}
