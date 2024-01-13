import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Forgot Password?     ",
          style:
              AppFonts.button.copyWith(fontSize: 13, color: AppColors.logo),
        ),
      ],
    );
  }
}
