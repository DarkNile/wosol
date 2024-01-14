import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/emailTextField.dart';
import 'package:wosol/shared/widgets/shared_widgets/forgot_password.dart';
import 'package:wosol/shared/widgets/shared_widgets/loginButton.dart';
import 'package:wosol/shared/widgets/shared_widgets/passwordField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 67.0),
            child: SvgPicture.asset(
              "assets/icons/logo.svg",
              width: 97,
              height: 65,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Column(
              children: [
                Text(
                  "Welcome 👋".tr,
                  style: AppFonts.header.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your account here",
                  style: AppFonts.medium.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkBlue500Base),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          EmailField(
            hint: "Email".tr,
            label: "Email".tr,
          ),
          const SizedBox(
            height: 24,
          ),
          PasswordField(),
          const SizedBox(
            height: 12,
          ),
          const ForgotPassword(),
          const SizedBox(
            height: 24,
          ),
          const CustomButton(
            text: "Login",
          )
        ],
      ),
    );
  }
}
