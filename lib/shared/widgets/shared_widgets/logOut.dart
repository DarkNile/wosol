import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/icons/logout.svg"),
        DefaultTextButton(
          function: () {},
          text: "Logout",
          textStyle: AppFonts.medium.copyWith(
            color: AppColors.error600,
          ),
        )
      ],
    );
  }
}
