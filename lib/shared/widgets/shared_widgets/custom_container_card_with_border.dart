import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';

class CustomContainerCardWithBorderWidget extends StatelessWidget {
  final Widget child;
  final double? height;
  const CustomContainerCardWithBorderWidget(
      {super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 216,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(width: 1, color: AppColors.darkBlue100),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }
}
