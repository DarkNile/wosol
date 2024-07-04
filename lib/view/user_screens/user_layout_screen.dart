import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wosol/controllers/user_controllers/user_layout_controller.dart';
import 'package:wosol/view/shared_screens/main_screens/settings_screen.dart';
import 'package:wosol/view/shared_screens/notification_screen.dart';
import 'package:wosol/view/user_screens/home/user_home_screen.dart';
import 'package:wosol/view/user_screens/manage_my_trips/manage_my_trips_screen.dart';

import '../../controllers/shared_controllers/map_controller.dart';
import '../../controllers/user_controllers/user_home_controller.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/shared_widgets/bottom_sheets.dart';
import '../shared_screens/map_screen.dart';
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

  MapController mapController = Get.put(MapController());
  final UserHomeController userHomeController =
  Get.put(UserHomeController());

  @override
  void initState() {
    userLayoutController.navBarIndex.value = 0;
    userLayoutController .notificationTimer =
        Timer.periodic(const Duration(seconds: 30), (timer) {
          userLayoutController
              .getNotificationRequests(context: context)
              .then((value) {
              userHomeController.getTrips(containLoading: false);
                if(userLayoutController.studentNotifications != null) {
                  if(userLayoutController.studentNotifications!.type == 'trip_start' || userLayoutController.studentNotifications!.type == 'trip_attendace'){
                    showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        enableDrag: false,
                        builder: (context){
                      return RandomSheet(
                        headTitle: userLayoutController.studentNotifications!.title,
                        subTitle: userLayoutController.studentNotifications!.text,
                        function: (){
                          Get.back();
                        },
                      );
                    });
                  }else if(userLayoutController.studentNotifications!.type == 'trip_near'){
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      builder: (context) {
                        return RideStartBottomSheet(
                          firstButtonFunction: () async{
                            mapController.markerIcon =
                                await mapController.getBytesFromAsset(
                                'assets/images/where_to_vote.png', 70);
                            mapController.currentIcon =
                                await mapController.getBytesFromAsset(
                                'assets/images/person_pin_circle.png', 70);
                            mapController.targetLatLng = LatLng(double.parse(userLayoutController.studentNotifications!.trip.toLat), double.parse(userLayoutController.studentNotifications!.trip.toLong));
                            await mapController
                                .getCurrentLocation()
                                .then((value) async {
                              mapController.currentLatLng =
                                  LatLng(value.latitude, value.longitude);
                              await mapController.getCurrentTargetPolylinePoints();
                              mapController.cameraPosition = CameraPosition(
                                target: mapController.currentLatLng,
                                zoom: 14,
                              );
                              // mapController.userGetEstimatedTime(
                              //   originLatLng: mapController.currentLatLng,
                              //   destinationLatLng: mapController.targetLatLng,
                              // );
                              // mapController.userLiveLocation();
                            });
                            Get.back();
                            Get.to(() => const MapScreen(
                              students: [],
                            ));
                          },
                          secondButtonFunction: () {
                            Get.back();
                          },
                          secondButtonText: 'close'.tr,
                          headTitle: userLayoutController.studentNotifications!.title,
                          fromUser: true,
                          formTime: DateFormat(
                              'HH:mm',
                              AppConstants
                                  .isEnLocale
                                  ? 'en_US'
                                  : "ar")
                              .format(DateTime.parse(userLayoutController.studentNotifications!.trip.tripStart)),
                          toTime: DateFormat(
                              'HH:mm',
                              AppConstants
                                  .isEnLocale
                                  ? 'en_US'
                                  : "ar")
                              .format(DateTime.parse(userLayoutController.studentNotifications!.trip.tripEnd)),
                          formPlace: userLayoutController.studentNotifications!.trip.fromPlace,
                          toPlace: userLayoutController.studentNotifications!.trip.toPlace,
                          fromTitle: userLayoutController.studentNotifications!.trip.fromTitle,
                          toTitle: userLayoutController.studentNotifications!.trip.toTitle,
                          date: DateFormat(
                              'dd, MMM, yyyy',
                              AppConstants
                                  .isEnLocale
                                  ? 'en_US'
                                  : "ar")
                              .format(DateTime.parse(userLayoutController.studentNotifications!.trip.tripDate)),
                        );
                      },
                    );
                  }else if(userLayoutController.studentNotifications!.type == 'trip_end'){
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      builder: (context) {
                        return RideAndTripEndBottomSheet(
                          headTitle: 'rideEnd'.tr,
                          imagePath: 'assets/images/celebrate.png',
                          headerMsg: '${"congrats".tr} ',
                          subHeaderMsg: 'rideCompletedSuccessfully'.tr,
                          isTrip: true,
                          function: () {
                            Get.offAll(()=> const UserLayoutScreen());
                          },
                        );
                      },
                    );
                  }
                }

          });
        });
    super.initState();
  }

  Future<void> onTapCancel({
    required BuildContext context,
    required bool isTrip,
    String? tripDate,
    String? calendarDate,
    required bool isCancel,
    required String userId,
  }) async {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => Obx(
              () => RideCanceledAndReportedBottomSheet(
            isCancel: isCancel,
            headTitle: isCancel ? 'Cancel Ride'.tr : 'Un Cancel Ride'.tr,
            isCancelFirstStep: true,
            imagePath: 'assets/images/thinking.png',
            headerMsg: isCancel
                ? 'You are about to cancel your ride, are you sure?'.tr
                : 'You are about to unCancel your ride, are you sure?'.tr,
            subHeaderMsg: isCancel
                ? 'Note: today trip only will be canceled'.tr
                : 'Note: today trip only will be uncanceled'.tr,
            firstButtonLoading: (isTrip &&
                userHomeController.tripCancelByDateLoading.value) ||
                (!isTrip &&
                    userHomeController.calendarCancelByDateLoading.value),
            firstButtonFunction: () async {
              log("UserID $userId");
              log("isCancel $isCancel");
              if (isTrip) {
                //  Cancel
                if (isCancel) {
                  await userHomeController.tripCancelByDateAPI(
                    context: context,
                    userId: userId,
                    date: tripDate!,
                    cancel: '1',
                    cancelReason: 'سبب الالغاء',
                  );
                } else {
                  // Un Cancel
                  await userHomeController.tripCancelByDateAPI(
                    context: context,
                    userId: userId,
                    date: tripDate!,
                    cancel: '0',
                  );
                }
              } else {
                //  Cancel
                if (isCancel) {
                  await userHomeController.calendarCancelByDateAPI(
                    context: context,
                    userId: userId,
                    date: calendarDate!,
                    cancel: '1',
                    cancelReason: 'سبب الالغاء',
                  );
                } else {
                  /// Un Cancel
                  await userHomeController.calendarCancelByDateAPI(
                    context: context,
                    userId: userId,
                    date: calendarDate!,
                    cancel: '0',
                  );
                }
              }
            },
            secondButtonFunction: () {
              Get.back();
            },
          ),
        ));
  }

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
