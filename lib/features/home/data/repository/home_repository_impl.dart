import 'package:todo_list_app/features/home/data/data.dart';
import 'package:todo_list_app/features/home/domain/domain.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalStorage _localStorage;

  HomeRepositoryImpl({required HomeLocalStorage localStorage})
    : _localStorage = localStorage;

  @override
  Future logout() async => await _localStorage.deleteCurrentUser();
}
