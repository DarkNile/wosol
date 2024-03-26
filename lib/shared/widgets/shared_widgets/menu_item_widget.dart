import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class MenuItemWidget extends StatelessWidget {
  final String svg;
  final String text;
  final bool withBorder;
  const MenuItemWidget(
      {super.key,
      required this.svg,
      required this.text,
      this.withBorder = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
          border: text == "canceled".tr || !withBorder
              ? null
              : const Border(
                  bottom: BorderSide(color: AppColors.popUpBottomSideColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svg,
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 8),
          Text(text,
              textAlign: TextAlign.center,
              style: AppFonts.medium.copyWith(
                color: AppColors.darkBlue700,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    );
  }
}
