import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/user_controllers/user_layout_controller.dart';
import 'package:wosol/view/shared_screens/auth/settings_screen.dart';
import 'package:wosol/view/shared_screens/notification_screen.dart';
import 'package:wosol/view/user_screens/home/user_home_screen.dart';
import 'package:wosol/view/user_screens/trips/user_trips_screen.dart';

import '../shared_screens/trip_history/trip_history_screen.dart';
import 'bottom_nav_bar_user.dart';

class UserLayoutScreen extends StatelessWidget {
  UserLayoutScreen({super.key});

  final UserLayoutController userLayoutController =
      Get.put<UserLayoutController>(UserLayoutController());
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const UserHomeScreen(),
      const UserTripsScreen(),
      const TripHistoryScreen(),
      const NotificationsScreen(),
      const SettingsScreen(),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Expanded(child: screens[userLayoutController.navBarIndex.value]);
            }),
            BottomNavigationBarUser(userLayoutController: userLayoutController,),
          ],
        ),
      ),
    );
  }
}
