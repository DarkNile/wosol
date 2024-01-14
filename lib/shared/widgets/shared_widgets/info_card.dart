import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 149,
      padding: AppConstants.edge(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10)),
      decoration: ShapeDecoration(
        color: const Color(0xFFFDFBF0),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.logo),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/logo.svg"),
          const SizedBox(height: 10),
          Text('For more edits you should Call Wosol'.tr,
              textAlign: TextAlign.center,
              style: AppFonts.medium
                  .copyWith(color: AppColors.black.withOpacity(.64))),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/call.svg"),
              const SizedBox(width: 10),
              Text('+966 123 456 789',
                  textAlign: TextAlign.center,
                  style: AppFonts.medium.copyWith(color: AppColors.logo)),
            ],
          ),
        ],
      ),
    );
  }
}
