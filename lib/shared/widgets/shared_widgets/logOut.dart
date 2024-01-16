import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Todo : User Our Custom Button it's DefaultRowButton And remove LogOutWidget
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/logout.svg"),
          const SizedBox(
            width: 6,
          ),
          DefaultTextButton(
            function: () {},
            text: "Logout".tr,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textColor: AppColors.error600,
          )
        ],
      ),
    );
  }
}
