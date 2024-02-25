import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/view/shared_screens/map_screen.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/widgets/shared_widgets/bottom_sheets.dart';
import 'widgets/ride_card.dart';

// ignore: must_be_immutable
class DriverHomeScreen extends StatelessWidget {
  DriverHomeScreen({super.key});
  MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    log("DriverHomeScreen");
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeader(
            header: AppConstants.userRepository.driverData.firstName,
            svgIcon: "",
            iconWidth: 0,
            iconHeight: 0,
            isHome: true,
          ),
          Padding(
            padding: AppConstants.edge(
              padding: const EdgeInsets.only(
                top: 14,
                bottom: 10,
                left: 16,
              ),
            ),
            child: Text(
              "nextRide".tr,
              style: AppFonts.header,
            ),
          ),
          RideCard(
            onTap: () async {
              await onTapRideCard(context);
            },
            title: 'Mecca Center',
            imgPath: "assets/images/home/upcoming_ride_icon.svg",
            time: "10 ${"mins".tr}",
            isNextRide: true,
          ),
          Padding(
            padding: AppConstants.edge(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 10,
                left: 16,
              ),
            ),
            child: Text(
              "upcomingRides".tr,
              style: AppFonts.header,
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const PageScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return RideCard(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => UpcomingRideBottomSheet(
                        headTitle: 'upcomingRide'.tr,
                        formTime: '10:05 am',
                        toTime: '11:30 am',
                        formPlace: 'Mecca ',
                        toPlace: 'King Abdelaziz University ',
                      ),
                    );
                  },
                  title: 'Mecca Center',
                  imgPath: "assets/images/home/education_trip_icon.svg",
                  time: "10:00 am",
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onTapRideCard(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => RideStartBottomSheet(
        firstButtonFunction: () async {
          mapController.targetLatLng =
              const LatLng(28.155398589482964, 30.73015619069338);
          if (AppConstants.isCaptain) {
            mapController.markerIcon = await mapController.getBytesFromAsset(
                'assets/images/location_on.png', 70);
            mapController.currentIcon = await mapController.getBytesFromAsset(
                'assets/images/navigation_arrow.png', 70);
          } else {
            mapController.markerIcon = await mapController.getBytesFromAsset(
                'assets/images/where_to_vote.png', 70);
            mapController.currentIcon = await mapController.getBytesFromAsset(
                'assets/images/person_pin_circle.png', 70);
          }
          await mapController.getCurrentLocation().then((value) async {
            mapController.currentLatLng =
                LatLng(value.latitude, value.longitude);
            await mapController.getCurrentTargetPolylinePoints();
            mapController.cameraPosition = CameraPosition(
              target: mapController.currentLatLng,
              zoom: 12,
            );
            mapController.getEstimatedTime(
                originLatLng: mapController.currentLatLng,
                destinationLatLng: mapController.targetLatLng);
            mapController.liveLocation();
          });
          Get.back();
          Get.to(() => const MapScreen());
          // showModalBottomSheet(
          //     context: context,
          //     builder: (context) => ConfirmPickupBottomSheet(
          //           title: 'confirmPickup'.tr,
          //           subTitle: 'canceled'.tr,
          //           firstButtonFunction: () {
          //             Get.back();
          //             showModalBottomSheet(
          //                 context: context,
          //                 builder: (context) => SelectUsersToPickupBottomSheet(
          //                       function: () {
          //                         Get.back();
          //                         showModalBottomSheet(
          //                             context: context,
          //                             builder: (context) =>
          //                                 _rideAndTripEndBottomSheet());
          //                       },
          //                       headTitle: 'Select users to pickup'.tr,
          //                       titles: const ['Hossam', 'Mostafa Ahmed'],
          //                       subTitles: const [
          //                         'Future st, building no 13',
          //                         'Future st, building no 13'
          //                       ],
          //                     ));
          //           },
          //           secondButtonFunction: () {
          //             Get.back();
          //             showModalBottomSheet(
          //                 context: context,
          //                 isScrollControlled: true,
          //                 builder: (context) =>
          //                     CancellationReasonAndReportRideBottomSheet(
          //                       function: () {
          //                         Get.back();
          //                         showModalBottomSheet(
          //                             context: context,
          //                             builder: (context) =>
          //                                 (SelectUsersToPickupBottomSheet(
          //                                   function: () {
          //                                     Get.back();
          //                                     showModalBottomSheet(
          //                                         context: context,
          //                                         builder: (context) =>
          //                                             _rideAndTripEndBottomSheet());
          //                                   },
          //                                   headTitle:
          //                                       'Select users to pickup'.tr,
          //                                   titles: const [
          //                                     'Hossam',
          //                                     'Mostafa Ahmed'
          //                                   ],
          //                                   subTitles: const [
          //                                     'Future st, building no 13',
          //                                     'Future st, building no 13'
          //                                   ],
          //                                 )));
          //                       },
          //                       headTitle: "cancelationReason".tr,
          //                       reasons: [
          //                         "noShow".tr,
          //                         "userCanceledTheTrip".tr,
          //                         "canceledByCustomer".tr,
          //                         'other'.tr,
          //                       ],
          //                       reasonsSelectedIndex: 3,
          //                     ));
          //           },
          //         ));
        },
        headTitle: '${"rideStartWithin".tr} 59 sec',
        formTime: '10:05 am',
        toTime: '11:30 am',
        formPlace: 'Mecca ',
        toPlace: 'King Abdelaziz University',
      ),
    );
  }

  Widget _rideAndTripEndBottomSheet() {
    return RideAndTripEndBottomSheet(
      headTitle: 'rideEnd'.tr,
      imagePath: 'assets/images/celebrate.png',
      headerMsg: '${"congrats".tr} ',
      subHeaderMsg: 'rideCompletedSuccessfully'.tr,
    );
  }
}
