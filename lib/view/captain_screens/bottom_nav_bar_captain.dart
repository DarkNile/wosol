import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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
        currentIndex: driverLayoutController.navBarIndex.value,
        onTap: (int index) {
          driverLayoutController.changeNavBarIndexValue(index);
        },
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedLabelStyle: AppFonts.SelectedStyle,
        unselectedLabelStyle: AppFonts.unSelectedStyle,
        selectedItemColor: AppColors.logo,
        unselectedItemColor: AppColors.darkBlue300,
        items: [
          BottomNavigationBarItem(
            // Todo : missing label Padding from top 3 like figma so make it Colum and remove label
            // Todo : missing localization

            icon: Column(
              children: [
                SvgPicture.asset(
                  "assets/icons/home.svg",
                  height: 24,
                  width: 24,
                ),
              ],
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Activehome.svg",
              height: 24,
              width: 24,
            ),
            label: "Home",
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
              label: "History"),
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
              label: "Notifications"),
          BottomNavigationBarItem(
              icon: Stack(children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFFF5F6F9),
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
                // Todo : "assets/icons/User.svg" Not found
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.dividerColor,
                  child: SvgPicture.asset(
                    "assets/icons/User.svg",
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
              label: "More"),
        ],
      );
    });
  }
}
