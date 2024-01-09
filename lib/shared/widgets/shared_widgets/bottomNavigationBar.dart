import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarr extends StatelessWidget {
  const BottomNavigationBarr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/home.svg"), label: "Home"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/rotate-left.svg"),
            label: "History"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/navNotification.svg"),
            label: "Notifications"),
        BottomNavigationBarItem(
            icon: Stack(children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFFF5F6F9),
                child: SvgPicture.asset("assets/icons/user.svg"),
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
