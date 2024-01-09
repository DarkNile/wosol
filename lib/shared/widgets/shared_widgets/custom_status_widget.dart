import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class CustomStatusWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  const CustomStatusWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          image,
          height: 65,
          width: 65,
        ),

        const SizedBox(
          height: 16,
        ),
        //Title

        Text(title,
            style: AppFonts.button.copyWith(
              fontSize: 20.0.sp(context),
              color: AppColors.logo,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(
          height: 16,
        ),

        //SubTitle
        Text(subTitle,
            style: AppFonts.medium.copyWith(
              fontSize: 14.0.sp(context),
              color: AppColors.darkBlue400,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
