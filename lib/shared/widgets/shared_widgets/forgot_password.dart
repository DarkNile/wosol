import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/view/shared_screens/auth/forget_password_screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(() => ForgetPasswordScreen());
      },
      child: Text(
        "Forgot Password?".tr,
        style: AppFonts.button.copyWith(fontSize: 13, color: AppColors.logo),
      ),
    );
  }
}
