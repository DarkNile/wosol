import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class CustomRowWithDotWidget extends StatelessWidget {
  final bool isGreen;
  final String text;

  const CustomRowWithDotWidget(
      {super.key, this.isGreen = true, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 9,
            height: 9,
            decoration: ShapeDecoration(
              color: isGreen ? AppColors.success600 : AppColors.error600,
              shape: const OvalBorder(),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: Text(text,
              softWrap: true,
              style: AppFonts.medium.copyWith(
                color: AppColors.darkBlue700,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              )),
        ),
      ],
    );
  }
}
