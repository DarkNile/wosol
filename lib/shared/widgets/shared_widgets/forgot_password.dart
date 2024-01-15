import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Todo : Remove Row ! and fix this space   =>  "Forgot Password?     "
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Forgot Password?     ".tr,
          style: AppFonts.button.copyWith(fontSize: 13, color: AppColors.logo),
        ),
      ],
    );
  }
}
