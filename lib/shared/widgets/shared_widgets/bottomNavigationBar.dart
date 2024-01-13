import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarr extends StatefulWidget {
  const BottomNavigationBarr({
    super.key,
  });

  @override
  State<BottomNavigationBarr> createState() => _BottomNavigationBarrState();
}

class _BottomNavigationBarrState extends State<BottomNavigationBarr> {
  int index=0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int index) {
        setState(() {
          index = this.index;
        });
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/home.svg"),
            activeIcon: SvgPicture.asset("assets/icons/Activehome.svg"),
            label: "Home"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/rotate-left.svg"),
            activeIcon: SvgPicture.asset("assets/icons/Activerotate-left.svg"),
            label: "History"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/navNotification.svg"),
            activeIcon: SvgPicture.asset("assets/icons/Activenotification.svg"),
            label: "Notifications"),
        BottomNavigationBarItem(
            icon: Stack(children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFFF5F6F9),
                child: SvgPicture.asset("assets/icons/nonActiveuser.svg"),
              ),
              Positioned(
                  top: 15,
                  left: 15,
                  child: SvgPicture.asset("assets/icons/menu.svg"))
            ]),
            activeIcon: Stack(children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFFF5F6F9),
                child: SvgPicture.asset("assets/icons/User.svg"),
              ),
              Positioned(
                  top: 15,
                  left: 15,
                  child: SvgPicture.asset("assets/icons/menu.svg"))
            ]),
            label: "More"),
      ],
    );
  }
}
