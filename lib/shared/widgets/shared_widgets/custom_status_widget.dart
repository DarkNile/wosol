import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class CustomStatusWidget extends StatelessWidget {
  final String lottiePath;
  final String title;
  final String subTitle;
  const CustomStatusWidget(
      {super.key,
      required this.lottiePath,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Lottie.asset(
          lottiePath,
          height: 65,
          width: 65,
          fit: BoxFit.fill
        ),

        const SizedBox(
          height: 16,
        ),
        //Title

        Text(title,
            textAlign: TextAlign.center,
            style: AppFonts.button.copyWith(
              fontSize: 20.0.sp(context),
              color: AppColors.logo,
              fontWeight: FontWeight.w700,
            )),
        if(subTitle.isNotEmpty)
        const SizedBox(
          height: 16,
        ),

        //SubTitle
        if(subTitle.isNotEmpty)
        Text(subTitle,
            textAlign: TextAlign.center,
            style: AppFonts.medium.copyWith(
              fontSize: 14.0.sp(context),
              color: AppColors.darkBlue400,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
