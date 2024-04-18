import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/user_controllers/user_layout_controller.dart';
import 'package:wosol/view/shared_screens/main_screens/settings_screen.dart';
import 'package:wosol/view/shared_screens/notification_screen.dart';
import 'package:wosol/view/user_screens/home/user_home_screen.dart';
import 'package:wosol/view/user_screens/manage_my_trips/manage_my_trips_screen.dart';

import '../shared_screens/trip_history/trip_history_screen.dart';
import 'bottom_nav_bar_user.dart';

class UserLayoutScreen extends StatefulWidget {
  const UserLayoutScreen({super.key});

  @override
  State<UserLayoutScreen> createState() => _UserLayoutScreenState();
}

class _UserLayoutScreenState extends State<UserLayoutScreen> {
  final UserLayoutController userLayoutController =
      Get.put<UserLayoutController>(UserLayoutController());

  final List<Widget> screens = [
    const UserHomeScreen(),
    const ManageMyTripUsersScreen(),
    TripHistoryScreen(),
    const NotificationsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Expanded(
                child: screens[userLayoutController.navBarIndex.value]);
          }),
          BottomNavigationBarUser(
            userLayoutController: userLayoutController,
          ),
        ],
      ),
    );
  }
}
