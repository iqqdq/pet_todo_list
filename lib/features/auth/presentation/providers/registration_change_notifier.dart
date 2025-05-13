import 'package:flutter/foundation.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/auth/auth.dart';

class RegistrationChangeNotifier with ChangeNotifier {
  ScreenStateEnum _state = ScreenStateEnum.initial;
  ScreenStateEnum get state => _state;

  bool isEmailValid({required String email}) =>
      AuthValidator.validateEmail(email);

  bool isPasswordValid({required String password}) =>
      AuthValidator.validatePassword(password);

  bool isPasswordsAreMatch({
    required String password,
    required String confirmPassword,
  }) => password == confirmPassword;

  bool isValidToConfrim({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) =>
      name.length >= 2 &&
      isEmailValid(email: email) &&
      isPasswordsAreMatch(
        password: password,
        confirmPassword: confirmPassword,
      ) &&
      isPasswordValid(password: password);

  Future checkEmailValidating({required String email}) async {
    _state = ScreenStateEnum.initial;
    notifyListeners();

    _state =
        isEmailValid(email: email)
            ? ScreenStateEnum.success
            : ScreenStateEnum.error;
    notifyListeners();
  }

  Future checkEmailAvailability({required String email}) async {
    _state = ScreenStateEnum.initial;
    notifyListeners();

    if (isEmailValid(email: email)) {
      await sl.get<EmailAvailabilityUsecase>().call(email: email).then((value) {
        _state = value ? ScreenStateEnum.success : ScreenStateEnum.error;
        notifyListeners();
      });
    }
  }

  Future register({
    required String email,
    required String name,
    required String password,
  }) async => await sl.get<RegisterUsecase>().call(
    email: email,
    name: name,
    password: password,
  );
}
