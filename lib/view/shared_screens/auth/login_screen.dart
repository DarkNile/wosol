import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/emailTextField.dart';
import 'package:wosol/shared/widgets/shared_widgets/loginButton.dart';
import 'package:wosol/shared/widgets/shared_widgets/passwordField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [EmailField(), PasswordField(), LoginButton()],
    );
  }
}
