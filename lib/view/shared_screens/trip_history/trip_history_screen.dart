import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wosol/controllers/captain_controllers/trip_history_driver_controller.dart';
import 'package:wosol/controllers/user_controllers/trip_history_student_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/view/captain_screens/routes/map_screen.dart';
import 'package:wosol/view/captain_screens/trip_details/captain_trip_details_screen.dart';
import 'package:wosol/view/user_screens/trip_details/user_trip_details_screen.dart';

import '../../../models/trip_list_model.dart';
import '../../../shared/widgets/shared_widgets/custom_header.dart';
import '../../../shared/widgets/shared_widgets/trip_history_card.dart';

class TripHistoryScreen extends StatelessWidget {
  TripHistoryScreen({super.key});
  final TripHistoryDriverController tripHistoryDriverController =
      Get.put(TripHistoryDriverController());
  final TripHistoryStudentController tripHistoryStudentController =
      Get.put(TripHistoryStudentController());

  Future<void> getTrips() async {
    if (AppConstants.userType == 'Driver') {
      tripHistoryDriverController.getTripsHistory();
    } else if (AppConstants.userType == "Employee") {
      tripHistoryDriverController.getEmployeeTripsHistory();
    } else {
      tripHistoryStudentController.getTripsHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Trip History Screen");
    AppConstants.userType == 'Driver'
        ? log("Captain")
        : AppConstants.userType == 'Employee'
            ? log("Employee")
            : log("Student");
    getTrips();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeaderWithOptionalWidget(
            screenTitle: "tripsHistory".tr,
            // suffixWidget: IconButton(
            //   padding: AppConstants.edge(
            //     padding: const EdgeInsets.only(right: 16),
            //   ),
            //   onPressed: () {},
            //   icon: SvgPicture.asset("assets/images/filter_icon.svg"),
            // ),
            isWithBackArrow: false,
          ),
          Obx(
            () {
              // add or to user
              if (tripHistoryDriverController.isGettingTrips.value ||
                  tripHistoryStudentController.isGettingTrips.value) {
                return Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: Get.height / 3),
                      child: const CircularProgressIndicator()),
                );
              } // add or to user
              return (tripHistoryDriverController.tripsList.isEmpty && (AppConstants.userType == 'Driver') ||
                  (tripHistoryDriverController.employeeTripsList.isEmpty && AppConstants.userType == 'Employee')) ||
                      (tripHistoryStudentController.tripsList.isEmpty && AppConstants.userType == 'Student')
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height / 3),
                        child: Text(
                          "No Trips".tr,
                          style: AppFonts.header,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                          top: 14,
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        itemBuilder: (context, index) {
                          String dateString = AppConstants.userType == 'Driver'
                              ? tripHistoryDriverController
                                  .tripsList[index].tripDate!
                              : AppConstants.userType == "Employee"
                                  ? tripHistoryDriverController
                                      .employeeTripsList[index].tripDate
                                  : tripHistoryStudentController
                                      .tripsList[index].subData![0].tripDate!;
                          String time = AppConstants.userType == 'Driver'
                              ? tripHistoryDriverController
                                  .tripsList[index].tripTime!
                              : AppConstants.userType == "Employee"
                                  ? tripHistoryDriverController
                                      .employeeTripsList[index].tripTime
                                  : tripHistoryStudentController
                                      .tripsList[index].subData![0].tripTime!;

                          String toCity = AppConstants.userType == 'Driver'
                              ? tripHistoryDriverController
                                      .tripsList[index].to ??
                                  ''
                              : AppConstants.userType == "Employee"
                                  ? tripHistoryDriverController
                                      .employeeTripsList[index].companyName
                                  : tripHistoryStudentController
                                      .tripsList[index]
                                      .subData![0]
                                      .universityName!;

                          String fromCity = AppConstants.userType == 'Driver'
                              ? tripHistoryDriverController
                                  .tripsList[index].from??''
                              : AppConstants.userType == "Employee"
                                  ? tripHistoryDriverController
                                      .employeeTripsList[index].from
                                  : tripHistoryStudentController
                                      .tripsList[index].subData![0].from!;

                          DateTime originalDate = DateTime.parse(dateString);

                          String date =
                              DateFormat('MMM dd').format(originalDate);
                          return TripHistoryCard(
                            date: '$date  - $time',
                            fromCity: fromCity,
                            toCity: toCity,
                            buttonText: AppConstants.userType == "Employee"
                                ? "Map"
                                : 'rideDetails'.tr,
                            onTap: () {
                              if (AppConstants.userType == 'Driver') {
                                List<Student> canceledStudents = [];
                                List<Student> confirmedStudents = [];
                                if(tripHistoryDriverController
                                    .tripsList[index].students != null){
                                  if(tripHistoryDriverController
                                      .tripsList[index].students!.isNotEmpty){
                                    for (var student in tripHistoryDriverController
                                        .tripsList[index].students!) {
                                      if(student.attendance == '1'){
                                        confirmedStudents.add(student);
                                      } else{
                                        canceledStudents.add(student);
                                      }
                                    }
                                  }
                                }
                                Get.to(() => CaptainTripDetailsScreen(
                                      dateTime: '$date  - $time',
                                      from: fromCity,
                                      to: toCity,
                                  confirmedStudents: confirmedStudents,
                                  canceledStudents: canceledStudents,
                                    ));
                              } else if (AppConstants.userType == 'Student') {
                                Get.to(() => UserTripDetailsScreen(
                                      dateTime: '$date  - $time',
                                      from: fromCity,
                                      to: toCity,
                                      captainName: tripHistoryStudentController
                                          .tripsList[index]
                                          .subData![0]
                                          .driverName!,
                                  userId: tripHistoryStudentController
                                      .tripsList[index]
                                      .subData![0].userId!,
                                  tripId: tripHistoryStudentController
                                      .tripsList[index]
                                      .subData![0].tripId!,
                                  tripUserId: tripHistoryStudentController
                                      .tripsList[index]
                                      .subData![0].tripUserId!,
                                  tripType: tripHistoryStudentController
                                      .tripsList[index]
                                      .subData![0].userType!,
                                  isRated: tripHistoryStudentController
                                      .tripsList[index]
                                      .subData![0].isRated!,
                                    ));
                              } else {
                                Get.to(
                                  () => MapRoutesScreen(
                                    fromLatLng: LatLng(
                                        tripHistoryDriverController
                                            .employeeTripsList[index].fromLat,
                                        tripHistoryDriverController
                                            .employeeTripsList[index].fromLong),
                                    toLatLng: LatLng(
                                        tripHistoryDriverController
                                            .employeeTripsList[index].toLat,
                                        tripHistoryDriverController
                                            .employeeTripsList[index].toLong),
                                  ),
                                );
                              }
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        itemCount: AppConstants.userType == 'Driver'
                            ? tripHistoryDriverController.tripsList.length :
                        AppConstants.userType == "Employee"?
                        tripHistoryDriverController
                            .employeeTripsList.length
                            : tripHistoryStudentController.tripsList.length,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

/* Obx(
            () {
              if (tripController.isGettingTrips.value) {
                return Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: Get.height / 3),
                      child: const CircularProgressIndicator()),
                );
              }
              return tripController.tripsList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height / 3),
                        child: Text(
                          "No Trips".tr,
                          style: AppFonts.header,
                        ),
                      ),
                    )
                  : Expanded(
                      child:*/
