import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

import '../../controllers/user_controllers/user_layout_controller.dart';

class BottomNavigationBarUser extends StatelessWidget {
  const BottomNavigationBarUser({
    super.key,
    required this.userLayoutController,
  });

  final UserLayoutController userLayoutController;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        backgroundColor: AppColors.white,
        currentIndex: userLayoutController.navBarIndex.value,
        onTap: (int index) {
          userLayoutController.changeNavBarIndexValue(index);
        },
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedLabelStyle: AppFonts.selectedStyle,
        unselectedLabelStyle: AppFonts.unSelectedStyle,
        selectedItemColor: AppColors.logo,
        unselectedItemColor: AppColors.darkBlue300,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Activehome.svg",
              width: 24,
              height: 24,
            ),
            label: "homeNavBar".tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/NA-note.svg",
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Activenote.svg",
              width: 24,
              height: 24,
            ),
            label: "trips".tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/rotate-left.svg",
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Activerotate-left.svg",
              width: 24,
              height: 24,
            ),
            label: "history".tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/navNotification.svg",
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Activenotification.svg",
              width: 24,
              height: 24,
            ),
            label: "notifications".tr,
          ),
          BottomNavigationBarItem(
            icon: Stack(children: [
              SizedBox(
                width: 24,
                height: 24,
                child: CircleAvatar(
                  // radius: 12,
                  backgroundColor: AppColors.dividerColor,
                  child: SvgPicture.asset(
                    "assets/icons/nonActiveuser.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset("assets/icons/menu.svg"))
            ]),
            activeIcon: Stack(children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.dividerColor,
                child: SvgPicture.asset(
                  "assets/icons/user.svg",
                  width: 24,
                  height: 24,
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset("assets/icons/menu.svg"))
            ]),
            label: "more".tr,
          ),
        ],
      );
    });
  }
}
