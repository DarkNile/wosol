import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

import '../../controllers/captain_controllers/driver_layout_controller.dart';

class BottomNavigationBarCaptain extends StatelessWidget {
  final DriverLayoutController driverLayoutController;

  const BottomNavigationBarCaptain({
    Key? key,
    required this.driverLayoutController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        backgroundColor: AppColors.white,
        currentIndex: driverLayoutController.navBarIndex.value,
        onTap: (int index) {
          driverLayoutController.changeNavBarIndexValue(index);
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
              height: 24,
              width: 24,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Activehome.svg",
              height: 24,
              width: 24,
            ),
            label: "homeNavBar".tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/rotate-left.svg",
              height: 24,
              width: 24,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Activerotate-left.svg",
              height: 24,
              width: 24,
            ),
            label: "history".tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/navNotification.svg",
              height: 24,
              width: 24,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Activenotification.svg",
              height: 24,
              width: 24,
            ),
            label: "notifications".tr,
          ),
          BottomNavigationBarItem(
            icon: Stack(children: [
              SizedBox(
                width: 24,
                height: 24,
                child: CircleAvatar(
                  backgroundColor: AppColors.dividerColor,
                  child: SvgPicture.asset(
                    "assets/icons/nonActiveuser.svg",
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    "assets/icons/menu.svg",
                  ))
            ]),
            activeIcon: Stack(children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.dividerColor,
                child: SvgPicture.asset(
                  "assets/icons/user.svg",
                  height: 24,
                  width: 24,
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    "assets/icons/menu.svg",
                  ))
            ]),
            label: "more".tr,
          ),
        ],
      );
    });
  }
}
