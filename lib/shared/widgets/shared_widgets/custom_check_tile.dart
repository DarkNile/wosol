import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/circular_check_box.dart';

class CustomCheckTileWidget extends StatelessWidget {
  final bool isChecked;
  final void Function()? onTap;
  final bool withCircularCheckBox;
  final String title;
  const CustomCheckTileWidget(
      {super.key,
      this.isChecked = false,
      this.withCircularCheckBox = true,
      this.title = 'Driver arrived late',
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: !withCircularCheckBox ? 38 : 48,
        alignment:
            withCircularCheckBox ? Alignment.center : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: ShapeDecoration(
          color: isChecked ? AppColors.btnBackColor : const Color(0xFFF5F6F9),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color: isChecked ? AppColors.orange300 : AppColors.darkBlue100),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: !withCircularCheckBox
            ? Text(
                title,
                style: AppFonts.medium.copyWith(
                  color: isChecked ? AppColors.logo : AppColors.black800,
                  fontWeight: isChecked ? FontWeight.w600 : FontWeight.w400,
                ),
              )
            : Row(children: [
                CircularCheckBox(
                  isChecked: isChecked,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppFonts.medium.copyWith(
                    color: isChecked ? AppColors.logo : AppColors.black800,
                    fontWeight: isChecked ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ]),
      ),
    );
  }
}
