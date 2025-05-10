import 'package:flutter/foundation.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/core/di/di.dart';
import 'package:todo_list_app/features/auth/domain/domain.dart';

class LogInChangeNotifier with ChangeNotifier {
  ScreenStateEnum _state = ScreenStateEnum.initial;
  ScreenStateEnum get state => _state;

  bool isValid({required String email, required String password}) =>
      RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      ).hasMatch(email) &&
      password.length >= 6;

  Future checkCurrentUser() async {
    await sl.get<GetCurrentUserUsecase>().call().then((value) {
      _state =
          value == null ? ScreenStateEnum.initial : ScreenStateEnum.success;
      notifyListeners();
    });
  }

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
