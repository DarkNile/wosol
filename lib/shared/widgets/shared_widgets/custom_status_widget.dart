import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class CustomStatusWidget extends StatelessWidget {
  final String imagePath;
  final String? lottiePath;
  final String title;
  final String subTitle;
  final bool containLottie;
  const CustomStatusWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subTitle,
        this.containLottie = false,
        this.lottiePath,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 65,
          height: 65,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if(containLottie)
                OverflowBox(
                  maxHeight: 140,
                  minHeight: 140,
                  maxWidth: 105,
                  minWidth: 105,
                  child: Lottie.asset(
                      lottiePath!,
                      height: 140,
                      width: 105,
                      fit: BoxFit.fill
                  ),
                ),
              Image.asset(
                imagePath,
                height: 65,
                width: 65,
                fit: BoxFit.fill
              ),
            ],
          ),
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
