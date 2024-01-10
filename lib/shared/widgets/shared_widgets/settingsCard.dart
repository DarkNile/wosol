import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wosol/controllers/shared_controllers/icon_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.isSwitcher,
    required this.title,
  });
  final bool isSwitcher;
  final String title;
  @override
  Widget build(BuildContext context) {
    final IconController iconController = Get.put(IconController());
    return Container(
      height: AppConstants.screenHeight(context) * .1 - 20,
      margin: AppConstants.edge(padding: const EdgeInsets.all(2)),
      padding: AppConstants.edge(padding: const EdgeInsets.all(10)),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: isSwitcher
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppFonts.header,
                ),
                InkWell(
                  onTap: () {
                    iconController.toggleIcon();
                  },
                  child: Obx(() {
                    return iconController.isIconOn.value
                        ? SvgPicture.asset(
                            "assets/icons/GToggle.svg",
                          )
                        : SvgPicture.asset(
                            "assets/icons/Toggle.svg",
                          );
                  }),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppFonts.header,
                ),
                InkWell(
                  onTap: () {
                    iconController.toggleIcon();
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                )
              ],
            ),
    );
  }
}
