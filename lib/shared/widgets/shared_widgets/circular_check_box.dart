import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';

class CircularCheckBox extends StatelessWidget {
  const CircularCheckBox({super.key, required this.isChecked});

  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: isChecked ? AppColors.logo : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: !isChecked ? AppColors.black : Colors.transparent,
        ),
      ),
      child: isChecked
          ? const Center(
              child: Icon(
                Icons.check,
                size: 16.0,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
