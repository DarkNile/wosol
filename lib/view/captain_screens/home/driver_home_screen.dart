import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wosol/controllers/captain_controllers/home_driver_controller.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/view/captain_screens/traddy_trips/traddy_trips_list_screen.dart';
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
  MapController mapController = Get.find();
  HomeDriverController homeDriverController = Get.find<HomeDriverController>();

  bool isStartingTrip = false;

  @override
  void initState() {
    super.initState();
    if (mapController.positionStream != null) {
      mapController.positionStream!.cancel();
      mapController.positionStream = null;
    }
    if (context.mounted) {
      homeDriverController.getTrips(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await homeDriverController.getTrips(context);
        },
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
                fromDriver: true,
                          onTap: () async {
                            await onTapRideCard(
                              tripIsRunning: homeDriverController
                                  .driverNextRide[0].tripIsRunning,
                              tripDate: homeDriverController
                                  .driverNextRide[0].tripDate,
                              isReachStart: (homeDriverController
                                          .driverNextRide[0].tripType ==
                                      '3')
                                  ? homeDriverController
                                      .driverNextRide[0].isReachStart
                                  : false,
                              isEmployee: homeDriverController
                                      .driverNextRide[0].tripType ==
                                  '3',
                              isStudent: homeDriverController
                                  .driverNextRide[0].tripType ==
                                  '1',
                              firstTripType: homeDriverController
                                  .driverNextRide[0].tripRound != '2',
                              context: context,
                              vehicleId: homeDriverController
                                  .driverNextRide[0].vehicleId,
                              tripId:
                                  homeDriverController.driverNextRide[0].tripId,
                              fromLatLng: LatLng(
                                homeDriverController
                                            .driverNextRide[0].fromLat ==
                                        ''
                                    ? 0
                                    : double.parse(homeDriverController
                                        .driverNextRide[0].fromLat),
                                homeDriverController
                                            .driverNextRide[0].fromLong ==
                                        ''
                                    ? 0
                                    : double.parse(homeDriverController
                                        .driverNextRide[0].fromLong),
                              ),
                              toLatLng: LatLng(
                                double.parse(homeDriverController
                                    .driverNextRide[0].toLat),
                                double.parse(homeDriverController
                                    .driverNextRide[0].toLong),
                              ),
                              startDate: homeDriverController
                                  .driverNextRide[0].tripStart,
                              fromPlace:
                                  homeDriverController.driverNextRide[0].from,
                              toPlace:
                                  homeDriverController.driverNextRide[0].to,
                              fromTime: homeDriverController
                                  .driverNextRide[0].tripTime,
                              toTime: AppConstants.getTimeFromDateString(
                                homeDriverController.driverNextRide[0].tripEnd,
                              ),
                              companyName: homeDriverController
                                              .driverNextRide[0].tripType ==
                                          '2' ||
                                      homeDriverController
                                              .driverNextRide[0].tripType ==
                                          '3'
                                  ? homeDriverController
                                      .driverNextRide[0].companyName
                                  : null,
                              companyTelephone: homeDriverController
                                              .driverNextRide[0].tripType ==
                                          '2' ||
                                      homeDriverController
                                              .driverNextRide[0].tripType ==
                                          '3'
                                  ? homeDriverController
                                      .driverNextRide[0].companyTelephone
                                  : null,
                              companyEmail: homeDriverController
                                              .driverNextRide[0].tripType ==
                                          '2' ||
                                      homeDriverController
                                              .driverNextRide[0].tripType ==
                                          '3'
                                  ? homeDriverController
                                      .driverNextRide[0].companyEmail
                                  : null,
                              coType: homeDriverController
                                          .driverNextRide[0].coType ==
                                      ''
                                  ? null
                                  : homeDriverController
                                      .driverNextRide[0].coType,
                              students: homeDriverController
                                  .driverNextRide[0].students,
                            );
                          },
                          title: homeDriverController.driverNextRide[0].from,
                          imgPath:
                              homeDriverController.driverNextRide[0].tripType ==
                                      '1'
                                  ? "assets/images/home/education_trip_icon.svg"
                                  : homeDriverController
                                              .driverNextRide[0].tripType ==
                                          '2'
                                      ? "assets/icons/employee_trip.svg"
                                      : "assets/icons/tourism_trip.svg",
                          time: homeDriverController.driverNextRide[0].tripTime,
                date: DateFormat('yyyy-MM-dd',).format(DateTime.parse(homeDriverController
                    .driverTrips[0].tripDate)),
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
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 16),
                            itemCount: homeDriverController.driverTrips.length,
                            itemBuilder: (context, index) {
                              return RideCard(
                                fromDriver: true,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isDismissible: false,
                                    enableDrag: false,
                                    builder: (context) =>
                                        UpcomingRideBottomSheet(
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
                                title: homeDriverController
                                    .driverTrips[index].from,
                                imgPath: homeDriverController
                                            .driverTrips[index].tripType ==
                                        '1'
                                    ? "assets/images/home/education_trip_icon.svg"
                                    : homeDriverController
                                                .driverTrips[index].tripType ==
                                            '2'
                                        ? "assets/icons/employee_trip.svg"
                                        : "assets/icons/tourism_trip.svg",
                                time: homeDriverController
                                    .driverTrips[index].tripTime,
                                date: DateFormat('yyyy-MM-dd').format(DateTime.parse(homeDriverController
                                    .driverTrips[0].tripDate)),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 12,
                            ),
                          )
                        : const SizedBox();
              }),
            ),
          ],
        ),
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
    required bool tripIsRunning,
    required bool isReachStart,
    required String? companyName,
    required String? companyTelephone,
    required String? companyEmail,
    required String? tripDate,
    required String? coType,
    required List<Student> students,
    bool isEmployee = false,
    required bool isStudent,
    required bool firstTripType,
  }) async {
    print("trippp ioddd $tripId");
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (bottomSheetContext) {
        return RideStartBottomSheet(
          tripId: tripId,
          firstButtonFunction: () async {
            Navigator.pop(bottomSheetContext);
            mapController.currentTripId = tripId;
            mapController.isFirstTripType = firstTripType;
            mapController.currentStudentIndex.value = 0;
            mapController.currentEndLat = toLatLng.latitude.toString();
            mapController.currentEndLong = toLatLng.longitude.toString();
            mapController.currentVehicleId = vehicleId;
            mapController.currentStudents = students;
            mapController.currentIsEmployee = isEmployee;
            mapController.currentIsStudent = isStudent;
            mapController.currentIsRound =
                (coType != null && coType == 'round');
            mapController.positionStream?.cancel();
            mapController.positionStream = null;
            try {
              setState(() {
                mapController.isToEnd = isReachStart;
              });

              if (tripIsRunning) {
                if (coType != null && coType == 'traddy') {
                  homeDriverController
                      .getTraddyTripsAPI(context: context, tripId: tripId)
                      .then((value) {
                    // Get.back();
                    Get.to(() => TraddyTripsScreen(
                          homeDriverController: homeDriverController,
                          tripId: tripId,
                          fromLatLng: fromLatLng,
                          toLatLng: toLatLng,
                          mapController: mapController,
                        ));
                  });
                } else {
                  if (isEmployee) {
                    mapController.targetLatLng = fromLatLng;
                  } else {
                    setState(() {
                      isStartingTrip = true;
                    });
                    if (students.isNotEmpty) {
                      mapController.targetLatLng = LatLng(
                        double.parse(
                          students[mapController.currentStudentIndex.value]
                              .pickupLat,
                        ),
                        double.parse(
                          students[mapController.currentStudentIndex.value]
                              .pickupLong,
                        ),
                      );
                    } else {
                      mapController.targetLatLng = toLatLng;
                    }
                    // mapController.finalLatLng = toLatLng;
                  }

                  // mapController.targetLatLng = toLatLng;

                  mapController.markerIcon = await mapController
                      .getBytesFromAsset('assets/images/location_on.png', 50);
                  mapController.currentIcon =
                      await mapController.getBytesFromAsset(
                          'assets/images/navigation_arrow.png', 50);

                  await mapController.getCurrentLocation().then((value) async {
                    mapController.currentLatLng =
                        LatLng(value.latitude, value.longitude);
                    // if (mapController.finalLatLng != null) {
                    //   await mapController.getCurrentFinalPolylinePoints();
                    // }
                    await mapController.getCurrentTargetPolylinePoints();
                    mapController.cameraPosition = CameraPosition(
                      target: mapController.currentLatLng,
                      bearing: mapController.bearing,
                      zoom: 19,
                    );
                    print("gettt estimatedd ${tripId}");
                    mapController.getEstimatedTime(
                        originLatLng: mapController.currentLatLng,
                        destinationLatLng: mapController.targetLatLng,
                        students: students,
                        tripId: tripId,
                        isEmployee: isEmployee,
                        isStudent: isStudent,
                        firstTripType: firstTripType,
                        endLat: toLatLng.latitude.toString(),
                        endLong: toLatLng.longitude.toString(),
                        isRound: (coType != null && coType == 'round'));
                    print("live stresaaaam $tripId");
                    mapController.liveLocation(
                        students: students,
                        tripId: tripId,
                        isEmployee: isEmployee,
                        isStudent: isStudent,
                        firstTripType: firstTripType,
                        endLat: toLatLng.latitude.toString(),
                        endLong: toLatLng.longitude.toString(),
                        vehicleId: vehicleId,
                        isRound: (coType != null && coType == 'round'));
                  });

                  setState(() {
                    isStartingTrip = false;
                  });
                  if (students.isNotEmpty &&
                      !(coType != null && coType == 'round')) {
                    mapController.nearbyStudent(
                      driverId: AppConstants.userRepository.driverData.driverId,
                      tripId: tripId,
                      userId: students[mapController.currentStudentIndex.value]
                          .userId,
                      tripUserId:
                          students[mapController.currentStudentIndex.value]
                              .tripUserId,
                    );
                  }

                  Get.to(() => MapScreen(
                        students: students,
                        tripId: tripId,
                        isRound: (coType != null && coType == 'round'),
                      ));
                }
              } else {
                homeDriverController
                    .tripStatesAPI(
                  context: context,
                  tripId: tripId,
                  state: 0,
                )
                    .then((value) async {
                  if (coType != null && coType == 'traddy') {
                    homeDriverController
                        .getTraddyTripsAPI(context: context, tripId: tripId)
                        .then((value) {
                      // Get.back();
                      Get.to(() => TraddyTripsScreen(
                            homeDriverController: homeDriverController,
                            tripId: tripId,
                            fromLatLng: fromLatLng,
                            toLatLng: toLatLng,
                            mapController: mapController,
                          ));
                    });
                  } else {
                    setState(() {
                      isStartingTrip = true;
                    });
                    if (isEmployee) {
                      mapController.targetLatLng = fromLatLng;
                    } else {
                      print("sssss ${mapController.currentStudentIndex.value}");
                      if (students.isNotEmpty) {
                        mapController.targetLatLng = LatLng(
                          double.parse(
                            students[mapController.currentStudentIndex.value]
                                .pickupLat,
                          ),
                          double.parse(
                            students[mapController.currentStudentIndex.value]
                                .pickupLong,
                          ),
                        );
                      } else {
                        mapController.targetLatLng = toLatLng;
                      }
                      // mapController.finalLatLng = toLatLng;
                    }

                    // mapController.targetLatLng = toLatLng;

                    mapController.markerIcon = await mapController
                        .getBytesFromAsset('assets/images/location_on.png', 50);
                    mapController.currentIcon =
                        await mapController.getBytesFromAsset(
                            'assets/images/navigation_arrow.png', 50);

                    await mapController
                        .getCurrentLocation()
                        .then((value) async {
                      mapController.currentLatLng =
                          LatLng(value.latitude, value.longitude);
                      // if (mapController.finalLatLng != null) {
                      //   await mapController.getCurrentFinalPolylinePoints();
                      // }
                      await mapController.getCurrentTargetPolylinePoints();
                      mapController.cameraPosition = CameraPosition(
                        target: mapController.currentLatLng,
                        bearing: mapController.bearing,
                        zoom: 19,
                      );
                      mapController.getEstimatedTime(
                        originLatLng: mapController.currentLatLng,
                        destinationLatLng: mapController.targetLatLng,
                        students: students,
                        tripId: tripId,
                        isEmployee: isEmployee,
                        isStudent: isStudent,
                        firstTripType: firstTripType,
                        endLat: toLatLng.latitude.toString(),
                        endLong: toLatLng.longitude.toString(),
                        isRound: (coType != null && coType == 'round'),
                      );
                      print("live stresaaaam 2 $tripId");
                      mapController.liveLocation(
                        students: students,
                        tripId: tripId,
                        isEmployee: isEmployee,
                        isStudent: isStudent,
                        firstTripType: firstTripType,
                        endLat: toLatLng.latitude.toString(),
                        endLong: toLatLng.longitude.toString(),
                        vehicleId: vehicleId,
                        isRound: (coType != null && coType == 'round'),
                      );
                    });
                    setState(() {
                      isStartingTrip = false;
                    });

                    // Get.back();
                    if (students.isNotEmpty &&
                        !(coType != null && coType == 'round')) {
                      mapController.nearbyStudent(
                        driverId:
                            AppConstants.userRepository.driverData.driverId,
                        tripId: tripId,
                        userId:
                            students[mapController.currentStudentIndex.value]
                                .userId,
                        tripUserId:
                            students[mapController.currentStudentIndex.value]
                                .tripUserId,
                      );
                    }
                    Get.to(() => MapScreen(
                          students: students,
                          tripId: tripId,
                          isRound: (coType != null && coType == 'round'),
                        ));
                  }
                });
              }
            } catch (e) {
              print("eeeeee $e");
            }
          },
          firstButtonText:
              (tripIsRunning && coType != null && coType == 'traddy')
                  ? "tripDetails".tr
                  : tripIsRunning
                      ? "goToMap".tr
                      : null,
          headTitle:
              '${"rideStartWithin".tr} ${AppConstants.getTimeDifference(startDate)}',
          formTime: fromTime,
          toTime: toTime,
          formPlace: fromPlace,
          isLoading: isStartingTrip,
          toPlace: toPlace,
          companyName: companyName,
          companyTelephone: companyTelephone,
          companyEmail: companyEmail,
        );
      },
    );
  }

// Widget _rideAndTripEndBottomSheet() {
//   return RideAndTripEndBottomSheet(
//     headTitle: 'rideEnd'.tr,
//     imagePath: 'assets/images/celebrate.png',
//     headerMsg: '${"congrats".tr} ',
//     subHeaderMsg: 'rideCompletedSuccessfully'.tr,
//   );
// }
}
