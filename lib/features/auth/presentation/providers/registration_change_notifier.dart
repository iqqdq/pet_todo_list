import 'package:flutter/foundation.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/auth/domain/domain.dart';

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
      RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      ).hasMatch(email) &&
      password.length >= 6 &&
      password == confirmPassword;

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
