import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/view/captain_screens/bottom_nav_bar_captain.dart';
import 'package:wosol/view/captain_screens/home/driver_home_screen.dart';
import 'package:wosol/view/shared_screens/main_screens/settings_screen.dart';
import 'package:wosol/view/shared_screens/notification_screen.dart';

import '../../controllers/captain_controllers/driver_layout_controller.dart';
import '../../controllers/shared_controllers/map_controller.dart';
import '../../shared/widgets/captain_widgets/notification_ride_request.dart';
import '../shared_screens/trip_history/trip_history_screen.dart';

class DriverLayoutScreen extends StatefulWidget {
  const DriverLayoutScreen({super.key});

  @override
  State<DriverLayoutScreen> createState() => _DriverLayoutScreenState();
}

class _DriverLayoutScreenState extends State<DriverLayoutScreen> {
  final DriverLayoutController driverLayoutController =
      Get.put<DriverLayoutController>(DriverLayoutController());

  MapController mapController = Get.put(MapController());

  @override
  void initState() {
    driverLayoutController.notificationTimer =
        Timer.periodic(const Duration(minutes: 2), (timer) {
      driverLayoutController
          .getNotificationRequests(context: context)
          .then((value) {
        if (driverLayoutController.notificationRequests.isNotEmpty) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Material(
                color: Colors.transparent,
                child: NotificationRideRequest(
                  driverLayoutController: driverLayoutController,
                  mapController: mapController,
                ),
              );
            },
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const DriverHomeScreen(),
      TripHistoryScreen(),
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
