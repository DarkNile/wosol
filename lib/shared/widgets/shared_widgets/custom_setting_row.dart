import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/shared_controllers/icon_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class CustomSettingRowWidget extends StatelessWidget {
  const CustomSettingRowWidget({
    super.key,
    required this.isSwitcher,
    required this.title,
    this.lang = false,
    this.isManageScreen = false,
    this.onTapChangeLanguage,
    this.isWithArrow = true,
  });
  final bool isSwitcher;
  final String title;
  final bool lang;
  final bool isManageScreen;
  final bool isWithArrow;
  final void Function()? onTapChangeLanguage;

  @override
  Widget build(BuildContext context) {
    final IconController iconController = Get.put(IconController());
    return SizedBox(
      height: isManageScreen ? 26 : 51,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isManageScreen ? 0 : 12),
        child: isSwitcher
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: AppFonts.medium.copyWith(
                        color: AppColors.black800,
                      )),
                  InkWell(
                    onTap: () {
                      iconController.toggleIcon();
                    },
                    child: Obx(() {
                      return iconController.isIconOn.value
                          ? SvgPicture.asset(
                              "assets/icons/GToggle.svg",
                              height: 26,
                              width: 49,
                            )
                          : SvgPicture.asset(
                              "assets/icons/Toggle.svg",
                              height: 26,
                              width: 49,
                            );
                    }),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: AppFonts.medium.copyWith(
                        color: AppColors.black800,
                      )),
                  InkWell(
                    onTap: onTapChangeLanguage,
                    child: lang
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                AppConstants.isEnLocale ? "العربيه" : "English",
                                style: AppFonts.medium.copyWith(
                                  color: AppColors.darkBlue400,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (isWithArrow)
                                const SizedBox(
                                  width: 6,
                                ),
                              if (isWithArrow)
                                SvgPicture.asset(
                                  "assets/icons/arrow-right.svg",
                                  width: 16,
                                  height: 16,
                                ),
                            ],
                          )
                        : Icon(
                            AppConstants.isEnLocale
                                ? CupertinoIcons.arrow_right
                                : CupertinoIcons.arrow_left,
                            size: 16,
                            color: AppColors.black800,
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
