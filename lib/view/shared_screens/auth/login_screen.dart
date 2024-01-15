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
            // Todo : Should have SafeArea
            // Todo : Use AppColors  Not Colors.white,
            // Todo : missing Padding look at figma
            // Todo : 👋 Should be Svg not text

            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Padding(
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
                  // Todo look at figma should be 28 not 24
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
                          Image.asset(
                            "assets/images/welcome.png",
                            width: 23,
                            height: 23,
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
              // Todo : Label not like figma  -> fill color and icon color missing when user write
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
                  SizedBox(
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
