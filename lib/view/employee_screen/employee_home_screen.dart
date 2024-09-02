import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/controllers/employee_%20controllers/employee_controller.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/services/network/repositories/employee_repository.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_bottom_sheet_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/view/shared_screens/map_screen.dart';

import '../../../models/trip_list_model.dart';
import '../../../shared/constants/constants.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';
import '../captain_screens/home/widgets/ride_card.dart';

// ignore: must_be_immutable
class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  MapController mapController = Get.find();
  EmployeeController employeeController = Get.put(EmployeeController());
  EmployeeRepository employeeRepository = Get.put(EmployeeRepository());

  @override
  void initState() {
    employeeController.getTrips(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await employeeController.getTrips(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
              header: AppConstants.userRepository.employeeData.firstName,
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
              return employeeController.isGettingTrips.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : employeeController.employeeNextRide.isNotEmpty
                      ? RideCard(
                fromDriver: false,
                          onTap: () async {
                            await onTapRideCard(
                              tripIsRunning: employeeController
                                  .employeeNextRide[0].tripIsRunning,
                              tripDate: employeeController
                                  .employeeNextRide[0].tripDate,
                              isReachStart: (employeeController
                                          .employeeNextRide[0].tripType ==
                                      '3')
                                  ? employeeController
                                      .employeeNextRide[0].isReachStart
                                  : false,
                              isEmployee: employeeController
                                      .employeeNextRide[0].tripType ==
                                  '3',
                              context: context,
                              vehicleId: employeeController
                                  .employeeNextRide[0].vehicleId,
                              tripId:
                                  employeeController.employeeNextRide[0].tripId,
                              fromLatLng: LatLng(
                                employeeController
                                            .employeeNextRide[0].fromLat ==
                                        ''
                                    ? 0
                                    : double.parse(employeeController
                                        .employeeNextRide[0].fromLat),
                                employeeController
                                            .employeeNextRide[0].fromLong ==
                                        ''
                                    ? 0
                                    : double.parse(employeeController
                                        .employeeNextRide[0].fromLong),
                              ),
                              toLatLng: LatLng(
                                double.parse(employeeController
                                    .employeeNextRide[0].toLat),
                                double.parse(employeeController
                                    .employeeNextRide[0].toLong),
                              ),
                              startDate: employeeController
                                  .employeeNextRide[0].tripStart,
                              fromPlace:
                                  employeeController.employeeNextRide[0].from,
                              toPlace:
                                  employeeController.employeeNextRide[0].to,
                              fromTime: employeeController
                                  .employeeNextRide[0].tripTime,
                              toTime: AppConstants.getTimeFromDateString(
                                employeeController.employeeNextRide[0].tripEnd,
                              ),
                              companyName: employeeController
                                              .employeeNextRide[0].tripType ==
                                          '2' ||
                                      employeeController
                                              .employeeNextRide[0].tripType ==
                                          '3'
                                  ? employeeController
                                      .employeeNextRide[0].companyName
                                  : null,
                              companyTelephone: employeeController
                                              .employeeNextRide[0].tripType ==
                                          '2' ||
                                      employeeController
                                              .employeeNextRide[0].tripType ==
                                          '3'
                                  ? employeeController
                                      .employeeNextRide[0].companyTelephone
                                  : null,
                              companyEmail: employeeController
                                              .employeeNextRide[0].tripType ==
                                          '2' ||
                                      employeeController
                                              .employeeNextRide[0].tripType ==
                                          '3'
                                  ? employeeController
                                      .employeeNextRide[0].companyEmail
                                  : null,
                              coType: employeeController
                                          .employeeNextRide[0].coType ==
                                      ''
                                  ? null
                                  : employeeController
                                      .employeeNextRide[0].coType,
                              students: employeeController
                                  .employeeNextRide[0].students,
                            );
                          },
                          title: employeeController.employeeNextRide[0].coType == 'traddy'? 'Traddy'.tr : employeeController.employeeNextRide[0].from,
                          imgPath:
                              employeeController.employeeNextRide[0].tripType ==
                                      '1'
                                  ? "assets/images/home/education_trip_icon.svg"
                                  : employeeController
                                              .employeeNextRide[0].tripType ==
                                          '2'
                                      ? "assets/icons/employee_trip.svg"
                                      : "assets/icons/tourism_trip.svg",
                          time: "${'from'.tr} ${employeeController.employeeNextRide[0].tripTime} ${'to'.tr} ${employeeController.employeeNextRide[0].tripTimeEnd}",
                companyName: employeeController.employeeNextRide[0].companyName,
                isTraddy: true,
                          isNextRide: true,
                        )
                      : const SizedBox();
            }),
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
  }) async {
    employeeController.getGroupsList(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Obx(() {
        return CustomBottomSheetWidget(
          height: AppConstants.screenHeight(context) * .6,
          headTitle: "Groups",
          child: employeeController.isGettingGroups.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) => TextButton(
                        child: Text(
                          employeeController.groups[index].groupName,
                          textAlign: TextAlign.start,
                        ),
                        onPressed: () async {
                          Get.back();

                          mapController.markerIcon =
                              await mapController.getBytesFromAsset(
                                  'assets/images/where_to_vote.png', 70);
                          mapController.currentIcon =
                              await mapController.getBytesFromAsset(
                                  'assets/images/person_pin_circle.png', 70);
                          mapController.targetLatLng = toLatLng;
                          await mapController
                              .getCurrentLocation()
                              .then((value) async {
                            mapController.currentLatLng =
                                LatLng(value.latitude, value.longitude);
                            await mapController
                                .getCurrentTargetPolylinePoints();
                            mapController.cameraPosition = CameraPosition(
                              target: mapController.currentLatLng,
                              zoom: 14,
                            );
                              employeeController.requestRide(
                              groupId: employeeController.groups[index].groupId,
                              lat: value.latitude.toString(),
                              lng: value.longitude.toString(),
                                date: tripDate!,
                            );


                            // mapController.userGetEstimatedTime(
                            //   originLatLng: mapController.currentLatLng,
                            //   destinationLatLng: mapController.targetLatLng,
                            // );
                            // mapController.userLiveLocation();
                          });
                        },
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                  itemCount: employeeController.groups.length),
        );
      }),
    );
  }
}
