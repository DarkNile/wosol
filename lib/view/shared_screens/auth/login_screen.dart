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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:
            // Todo :  SafeArea should be inside Scaffold
            // Todo : Use AppColors  Not Colors.white

            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Padding(
                  // Todo : After SafeArea look at figma it't not 67
                  padding: const EdgeInsets.only(top: 67.0),
                  child: SvgPicture.asset(
                    "assets/icons/logo.svg",
                    width: 97,
                    height: 65,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 28),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome ".tr,
                            style: AppFonts.header.copyWith(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Image.asset(
                            "assets/images/welcome.png",
                            width: 22,
                            height: 22,
                          )
                        ],
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
              ),
              const SizedBox(
                height: 24,
              ),

              // Todo : height should be 48 default is 58
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email".tr,
                    style: AppFonts.style12Urb.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBlue500Base),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  EmailField(
                    hint: "Email".tr,
                    label: '',
                  ),
                ],
              ),

              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password".tr,
                    style: AppFonts.style12Urb.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBlue500Base),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PasswordField(),
                ],
              ),

              const SizedBox(
                height: 12,
              ),
              const ForgotPassword(),
              const SizedBox(
                height: 24,
              ),
              const CustomButton(
                text: "Login",
                // Todo : borderRadius 8 but default is 10
                color: AppColors.logo,
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
