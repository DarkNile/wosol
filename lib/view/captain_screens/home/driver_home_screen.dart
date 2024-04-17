import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/controllers/captain_controllers/home_driver_controller.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/view/shared_screens/map_screen.dart';

import '../../../models/trip_list_model.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/widgets/shared_widgets/bottom_sheets.dart';
import 'widgets/ride_card.dart';

// ignore: must_be_immutable
class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  MapController mapController = Get.put(MapController());
  HomeDriverController homeDriverController = Get.put(HomeDriverController());
  bool isStartingTrip = false;

  @override
  void initState() {
    homeDriverController.getTrips(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          Obx(() {
            return homeDriverController.isGettingTrips.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : homeDriverController.driverNextRide.isNotEmpty
                    ? RideCard(
                        onTap: () async {
                          await onTapRideCard(
                            context: context,
                            vehicleId: homeDriverController
                                .driverNextRide[0].vehicleId,
                            tripId:
                                homeDriverController.driverNextRide[0].tripId,
                            fromLatLng: LatLng(
                              double.parse(homeDriverController
                                  .driverNextRide[0].fromLat),
                              double.parse(homeDriverController
                                  .driverNextRide[0].fromLong),
                            ),
                            toLatLng: LatLng(
                              double.parse(
                                  homeDriverController.driverNextRide[0].toLat),
                              double.parse(homeDriverController
                                  .driverNextRide[0].toLong),
                            ),
                            startDate: homeDriverController
                                .driverNextRide[0].tripStart,
                            fromPlace:
                                homeDriverController.driverNextRide[0].from,
                            toPlace: homeDriverController.driverNextRide[0].to,
                            fromTime:
                                homeDriverController.driverNextRide[0].tripTime,
                            toTime: AppConstants.getTimeFromDateString(
                              homeDriverController.driverNextRide[0].tripEnd,
                            ),
                            students:
                                homeDriverController.driverNextRide[0].students,
                          );
                        },
                        title: homeDriverController.driverNextRide[0].from,
                        imgPath: "assets/images/home/upcoming_ride_icon.svg",
                        time: homeDriverController.driverNextRide[0].tripTime,
                        isNextRide: true,
                      )
                    : const SizedBox();
          }),
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
            child: Obx(() {
              return homeDriverController.isGettingTrips.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : homeDriverController.driverTrips.isNotEmpty
                      ? ListView.separated(
                          physics: const PageScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 16),
                          itemCount: homeDriverController.driverTrips.length,
                          itemBuilder: (context, index) {
                            return RideCard(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => UpcomingRideBottomSheet(
                                    headTitle: 'upcomingRide'.tr,
                                    formTime: homeDriverController
                                        .driverTrips[index].tripTime,
                                    toTime: homeDriverController
                                        .driverTrips[index].tripTime,
                                    formPlace: homeDriverController
                                        .driverTrips[index].from,
                                    toPlace: homeDriverController
                                        .driverTrips[index].to,
                                  ),
                                );
                              },
                              title:
                                  homeDriverController.driverTrips[index].from,
                              imgPath:
                                  "assets/images/home/education_trip_icon.svg",
                              time: homeDriverController
                                  .driverTrips[index].tripTime,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                        )
                      : const SizedBox();
            }),
          ),
        ],
      ),
    );
  }

  Future<void> onTapRideCard({
    required BuildContext context,
    required String tripId,
    required String fromPlace,
    required String toPlace,
    required String fromTime,
    required String toTime,
    required String startDate,
    required LatLng fromLatLng,
    required LatLng toLatLng,
    required String vehicleId,
    required List<Student> students,
    bool isEmployee = false,
  }) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => RideStartBottomSheet(
        firstButtonFunction: () async {
          /// todo Move this to Trip Confirm
          // homeDriverController.tripStatesAPI(
          //   context: context,
          //   tripId: '32',
          //   state: 1,
          // );

          /// todo Move this to Trip End
          // homeDriverController.tripStatesAPI(
          //   context: context,
          //   tripId: '32',
          //   state: 2,
          // );

          /// todo Move this to Trip Attendance
          // homeDriverController.tripStatesAPI(
          //   context: context,
          //   tripId: '32',
          //   tripUserId: "99",
          //   attendance: "1",
          //   state: 3,
          // );

          homeDriverController
              .tripStatesAPI(
            context: context,
            tripId: tripId,
            state: 0,
          )
              .then((value) async {
            setState(() {
              isStartingTrip = true;
            });

            if (isEmployee) {
              mapController.targetLatLng = toLatLng;
            } else {
              mapController.targetLatLng = LatLng(
                double.parse(
                  students[mapController.currentStudentIndex.value].pickupLat,
                ),
                double.parse(
                  students[mapController.currentStudentIndex.value].pickupLong,
                ),
              );
            }

            // mapController.targetLatLng = toLatLng;
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
                destinationLatLng: mapController.targetLatLng,
                students: students,
                tripId: tripId,
                endLat: toLatLng.latitude.toString(),
                endLong: toLatLng.longitude.toString(),
              );
              mapController.liveLocation(
                students: students,
                tripId: tripId,
                endLat: toLatLng.latitude.toString(),
                endLong: toLatLng.longitude.toString(),
                vehicleId: vehicleId,
              );
            });
            setState(() {
              isStartingTrip = false;
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
          });
        },
        headTitle:
            '${"rideStartWithin".tr} ${AppConstants.getTimeDifference(startDate)}',
        formTime: fromTime,
        toTime: toTime,
        formPlace: fromPlace,
        isLoading: isStartingTrip,
        toPlace: toPlace,
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
