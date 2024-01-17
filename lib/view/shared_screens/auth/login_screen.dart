import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/shared/widgets/shared_widgets/forgot_password.dart';
import 'package:wosol/view/captain_screens/user_layout_screen.dart';
import 'package:wosol/view/user_screens/user_layout_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                          "Enter your account here".tr,
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
                    EmailTextField(
                        controller: TextEditingController(),
                        onSubmit: (String value) {},
                        hint: 'Email'.tr,
                        label: '',
                        validateText: "user.info@mail.com",
                        fieldValidation: TextFieldValidation.valid),
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
                    PasswordTextField(
                        controller: TextEditingController(),
                        fieldValidation: TextFieldValidation.valid,
                        onSubmit: (val) {},
                        label: '',
                        hintText: 'Password'.tr,
                        onChange: (val) {}),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const ForgotPassword(),
                const SizedBox(
                  height: 24,
                ),
                DefaultButton(
                  function: () {
                    Get.to(() => AppConstants.isCaptain
                        ? DriverLayoutScreen()
                        : UserLayoutScreen());
                  },
                  text: "Login".tr,
                  borderRadius: 8,
                  color: AppColors.logo,
                  height: 48,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
