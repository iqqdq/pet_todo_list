import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _logInChangeNotifier = LogInChangeNotifier();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  @override
  void initState() {
    _emailTextEditingController.addListener(() => setState(() {}));
    _passwordTextEditingController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final emailError =
        _logInChangeNotifier.state == ScreenStateEnum.error
            ? AppTitles.incorrectEmailOrPassword
            : null;

    final state =
        _logInChangeNotifier.isValid(
              email: _emailTextEditingController.text,
              password: _passwordTextEditingController.text,
            )
            ? PrimaryButtonState.initial
            : PrimaryButtonState.disabled;

    return Scaffold(
      body: ListenableBuilder(
        listenable: _logInChangeNotifier,
        builder: (context, _) {
          return AuthBackgroundView(
            children: [
              /// TITLE
              Text(AppTitles.logIn, style: AppTextStyles.title1Bold28pt),
              SizedBox(height: 28.0),

              /// EMAIL INPUT
              CustomTextField(
                controller: _emailTextEditingController,
                title: AppTitles.email,
                hintText: AppTitles.enterYourEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                error: emailError,
              ),
              SizedBox(height: 28.0),

              /// PASSWORD INPUT
              CustomTextField(
                controller: _passwordTextEditingController,
                title: AppTitles.password,
                hintText: AppTitles.enterYourPassword,
                obscureText: true,
              ),
              SizedBox(height: 42.0),

              /// CONFIRM BUTTON
              PrimaryButton(
                title: AppTitles.confirm,
                state: state,
                onTap: _onConfirmPressed,
              ),
              SizedBox(height: 12.0),

              /// SIGN UP BUTTON
              RichTextButton(
                title: '${AppTitles.dontHaveAnAccount} ',
                span: AppTitles.signUp,
                onPressed: _onSignUpPressed,
              ),
            ],
          );
        },
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  Future _onConfirmPressed() async {
    await _logInChangeNotifier.logIn(
      email: _emailTextEditingController.text,
      password: _passwordTextEditingController.text,
    );

    if (_logInChangeNotifier.state == ScreenStateEnum.success) {
      _showHomeScreen();
    }
  }

  void _onSignUpPressed() {
    FocusScope.of(context).unfocus();
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => RegistrationScreen()));
  }

  void _showHomeScreen() => Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => HomeScreen()),
    (Route<dynamic> route) => false,
  );
}
