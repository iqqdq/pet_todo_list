import 'package:flutter/foundation.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/auth/auth.dart';

class LogInChangeNotifier with ChangeNotifier {
  ScreenStateEnum? _state;
  ScreenStateEnum? get state => _state;

  bool isValid({required String email, required String password}) =>
      AuthValidator.validateEmail(email) &&
      AuthValidator.validatePassword(password);

  Future logIn({required String email, required String password}) async =>
      await sl.get<LogInUsecase>().call(email: email, password: password).then((
        value,
      ) {
        value == null
            ? _state = ScreenStateEnum.error
            : _state = ScreenStateEnum.success;
        notifyListeners();
      });
}
