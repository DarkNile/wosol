import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class CustomPopupMenuButton extends StatefulWidget {
  const CustomPopupMenuButton({super.key});

  @override
  State<CustomPopupMenuButton> createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
  String selectedValue = "endTrip";

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        offset: const Offset(0, 40),
        onSelected: (value) {},
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        shadowColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SvgPicture.asset(
            width: 24, height: 24, 'assets/icons/list_mobile.svg'),
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: "endTrip",
                  height: 42,
                  child: _MenuItemWidget(
                    svg: 'assets/icons/location-tick.svg',
                    text: "endTrip".tr,
                  )),
              PopupMenuItem(
                  height: 42,
                  value: "confirmPickup",
                  child: _MenuItemWidget(
                    svg: 'assets/icons/tick-square.svg',
                    text: "confirmPickup".tr,
                  )),
              PopupMenuItem(
                  height: 42,
                  value: "canceled",
                  child: _MenuItemWidget(
                    svg: 'assets/icons/canceled.svg',
                    text: "canceled".tr,
                  )),
            ]);
  }
}

class _MenuItemWidget extends StatelessWidget {
  final String svg;
  final String text;
  const _MenuItemWidget({required this.svg, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
          border: text == "canceled".tr
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
