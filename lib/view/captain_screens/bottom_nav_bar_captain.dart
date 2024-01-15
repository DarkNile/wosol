import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

// TODO : label style and svg height and width same not found
class BottomNavigationBarCaptain extends StatelessWidget {
  final int index;
  const BottomNavigationBarCaptain({Key? key, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int index) {
        index = index;
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedLabelStyle:AppFonts.SelectedStyle ,
      unselectedLabelStyle:AppFonts.unSelectedStyle ,
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
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFFF5F6F9),
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
  }
}
