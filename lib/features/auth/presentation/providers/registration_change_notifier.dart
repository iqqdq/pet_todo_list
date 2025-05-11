import 'package:flutter/foundation.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/auth/auth.dart';

class RegistrationChangeNotifier with ChangeNotifier {
  ScreenStateEnum _state = ScreenStateEnum.initial;
  ScreenStateEnum get state => _state;

  bool isValid({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) =>
      name.length >= 2 &&
      password == confirmPassword &&
      AuthValidator.validateEmail(email) &&
      AuthValidator.validatePassword(password);

  Future register({
    required String email,
    required String name,
    required String password,
  }) async => await sl
      .get<RegisterUsecase>()
      .call(email: email, name: name, password: password)
      .then((value) {
        value == null
            ? _state = ScreenStateEnum.error
            : _state = ScreenStateEnum.success;
        notifyListeners();
      });
}
