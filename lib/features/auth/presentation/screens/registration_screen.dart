import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _registrationChangeNotifier = RegistrationChangeNotifier();
  final _nameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _confirmPasswordTextEditingController = TextEditingController();

  @override
  void initState() {
    _nameTextEditingController.addListener(() => setState(() {}));
    _emailTextEditingController.addListener(() => setState(() {}));
    _passwordTextEditingController.addListener(() => setState(() {}));
    _confirmPasswordTextEditingController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthBackgroundView(
        children: [
          /// TITLE
          Text(AppTitles.registration, style: AppTextStyles.title1Bold28pt),
          SizedBox(height: 28.0),

          /// NAME INPUT
          CustomTextField(
            controller: _nameTextEditingController,
            title: AppTitles.name,
            hintText: AppTitles.enterYourFirstName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(height: 28.0),

          /// EMAIL INPUT
          CustomTextField(
            controller: _emailTextEditingController,
            title: AppTitles.email,
            hintText: AppTitles.enterYourEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            error:
                _registrationChangeNotifier.state == ScreenStateEnum.initial
                    ? null
                    : _registrationChangeNotifier.isEmailValid(
                          email: _emailTextEditingController.text,
                        ) ==
                        false
                    ? AppTitles.enterCorrectEmail
                    : _registrationChangeNotifier.state == ScreenStateEnum.error
                    ? AppTitles.accountWithThisEmailAlreadyExists
                    : '',
            onChanged:
                (value) => _registrationChangeNotifier.checkEmailAvailability(
                  email: _emailTextEditingController.text,
                ),
            onEditingComplete:
                () => {
                  FocusScope.of(context).nextFocus(),
                  // _registrationChangeNotifier.checkEmailAvailability(
                  //   email: _emailTextEditingController.text,
                  // ),
                },
          ),
          SizedBox(height: 28.0),

          /// PASSWORD INPUT
          CustomTextField(
            controller: _passwordTextEditingController,
            title: AppTitles.password,
            hintText: AppTitles.enterYourPassword,
            textInputAction: TextInputAction.next,
            obscureText: true,
            error:
                !_registrationChangeNotifier.isPasswordValid(
                      password: _passwordTextEditingController.text,
                    )
                    ? null
                    : AppTitles.atLeatFiveCharacters,
          ),
          SizedBox(height: 28.0),

          /// CONFIRM PASSWORD INPUT
          CustomTextField(
            controller: _confirmPasswordTextEditingController,
            title: AppTitles.confrimPassword,
            hintText: AppTitles.enterYourPasswordAgain,
            obscureText: true,
            error:
                _registrationChangeNotifier.isPasswordsAreMatch(
                      password: _passwordTextEditingController.text,
                      confirmPassword:
                          _confirmPasswordTextEditingController.text,
                    )
                    ? null
                    : AppTitles.passwordsMustMatch,
          ),

          SizedBox(height: 42.0),

          /// CONFIRM BUTTON
          PrimaryButton(
            title: AppTitles.register,
            state:
                _registrationChangeNotifier.isValidToConfrim(
                      name: _nameTextEditingController.text,
                      email: _emailTextEditingController.text,
                      password: _passwordTextEditingController.text,
                      confirmPassword:
                          _confirmPasswordTextEditingController.text,
                    )
                    ? PrimaryButtonState.initial
                    : PrimaryButtonState.disabled,
            onTap: _onRegisterPressed,
          ),
          SizedBox(height: 12.0),

          /// SIGN IN BUTTON
          RichTextButton(
            title: '${AppTitles.alreadyHaveAnAccount} ',
            span: AppTitles.signIn,
            onPressed: _onSignInPressed,
          ),
        ],
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onRegisterPressed() async {
    await _registrationChangeNotifier.register(
      name: _nameTextEditingController.text,
      email: _emailTextEditingController.text,
      password: _passwordTextEditingController.text,
    );

    _registrationChangeNotifier.state == ScreenStateEnum.error
        ? _showErrorAlert()
        : _showHomeScreen();
  }

  void _onSignInPressed() {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  void _showErrorAlert() => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text(AppTitles.accountWithThisEmailAlreadyExists)),
  );

  void _showHomeScreen() => Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => HomeScreen()),
    (Route<dynamic> route) => false,
  );
}
