import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class CaptainNumberWidget extends StatelessWidget {
  final String carNumber;
  final String carType;
  const CaptainNumberWidget(
      {super.key, required this.carNumber, required this.carType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/car_with_driver.png', height: 46),
        const Spacer(),
        Column(
          children: [
            // Car Number
            Text(carNumber,
                style: AppFonts.header.copyWith(color: AppColors.black800)),
            const SizedBox(height: 2),
            // Car Type
            Text(carType,
                style: AppFonts.medium.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black800))
          ],
        )
      ],
    );
  }
}
