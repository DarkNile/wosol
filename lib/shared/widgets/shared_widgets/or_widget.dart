import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: AppColors.darkBlue200,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text('Or',
            textAlign: TextAlign.center,
            style: AppFonts.medium.copyWith(
              color: AppColors.darkBlue300,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: AppColors.darkBlue200,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
