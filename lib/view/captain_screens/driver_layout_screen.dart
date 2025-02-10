import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wosol/view/captain_screens/bottom_nav_bar_captain.dart';
import 'package:wosol/view/captain_screens/home/driver_home_screen.dart';
import 'package:wosol/view/employee_screen/employee_home_screen.dart';
import 'package:wosol/view/shared_screens/main_screens/settings_screen.dart';
import 'package:wosol/view/shared_screens/notification_screen.dart';

import '../../controllers/captain_controllers/driver_layout_controller.dart';
import '../../controllers/captain_controllers/home_driver_controller.dart';
import '../../controllers/shared_controllers/map_controller.dart';
import '../../shared/constants/constants.dart';
import '../../shared/constants/style/colors.dart';
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

  HomeDriverController homeDriverController = Get.put(HomeDriverController());

  MapController mapController = Get.put(MapController());

  @override
  void initState() {
    // AppConstants.getFcmToken();
    // FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    //   AppConstants.fcmToken = newToken;
    // });

    // homeDriverController.getTrips(context);
    driverLayoutController.navBarIndex.value = 0;
    //todo 1
    // if (AppConstants.userType != 'Employee') {
    //   if (context.mounted) {
    //     driverLayoutController.notificationTimer =
    //         Timer.periodic(const Duration(minutes: 2), (timer) {
    //       driverLayoutController
    //           .getNotificationRequests(context: context)
    //           .then((value) {
    //         if (driverLayoutController.notificationRequests.isNotEmpty) {
    //           for (var i in homeDriverController.driverTrips) {
    //             if (driverLayoutController.notificationRequests
    //                         .any((element) => element.tripId == i.tripId) &&
    //                     i.tripType == "2" ||
    //                 i.tripType == "3") {
    //               showDialog(
    //                 barrierDismissible: false,
    //                 context: context,
    //                 builder: (context) {
    //                   return Material(
    //                     color: Colors.transparent,
    //                     child: NotificationRideRequest(
    //                       driverLayoutController: driverLayoutController,
    //                       mapController: mapController,
    //                       trip: i,
    //                     ),
    //                   );
    //                 },
    //               );
    //             }
    //           }
    //         }
    //       });
    //     });
    //   }
    // }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (context.mounted) {
      if (AppConstants.userType != 'Employee') {
        homeDriverController.getTrips(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      AppConstants.userType != 'Employee'
          ? const DriverHomeScreen()
          : const EmployeeHomeScreen(),
      TripHistoryScreen(),
      const NotificationsScreen(),
      const SettingsScreen(),
    ];
    // if (AppConstants.userType == 'Employee') {
    //   Future.delayed((Duration(seconds: 1)),(){
    //     print("uessssss");
    //   });
    //   // employeeController.getTrips(context);
    // }
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
      floatingActionButtonLocation: AppConstants.userType != 'Employee'? null : FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: AppConstants.userType != 'Employee'? null : Padding(
        padding: const EdgeInsets.only(bottom: 55),
        child: FloatingActionButton(
          onPressed: (){
            launchUrl(Uri.parse(
                "https://wa.me/${'+966 53 232 8393'}"));
          },
          elevation: 6,
          // backgroundColor: Colors.transparent,
          backgroundColor: AppColors.logo.withOpacity(0.8),
          child: SvgPicture.asset('assets/icons/whatsapp.svg', fit: BoxFit.fill, width: 50, height: 50,),
        ),
      ),
    );
  }
}
