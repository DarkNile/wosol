import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/view/captain_screens/bottom_nav_bar_captain.dart';
import 'package:wosol/view/captain_screens/home/driver_home_screen.dart';
import 'package:wosol/view/shared_screens/main_screens/settings_screen.dart';
import 'package:wosol/view/shared_screens/notification_screen.dart';

import '../../controllers/captain_controllers/driver_layout_controller.dart';
import '../shared_screens/trip_history/trip_history_screen.dart';

class DriverLayoutScreen extends StatelessWidget {
  DriverLayoutScreen({super.key});

  final DriverLayoutController driverLayoutController =
      Get.put<DriverLayoutController>(DriverLayoutController());
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      DriverHomeScreen(),
      const TripHistoryScreen(),
      const NotificationsScreen(),
      const SettingsScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Expanded(
                child: screens[driverLayoutController.navBarIndex.value]);
          }),
          BottomNavigationBarCaptain(
            driverLayoutController: driverLayoutController,
          ),
        ],
      ),
    );
  }
}
