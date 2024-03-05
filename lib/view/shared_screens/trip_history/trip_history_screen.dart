import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wosol/controllers/captain_controllers/trip_history_driver_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/view/captain_screens/trip_details/captain_trip_details_screen.dart';
import 'package:wosol/view/user_screens/trip_details/user_trip_details_screen.dart';

import '../../../shared/widgets/shared_widgets/custom_header.dart';
import '../../../shared/widgets/shared_widgets/trip_history_card.dart';

class TripHistoryScreen extends StatelessWidget {
  TripHistoryScreen({super.key});
  final TripHistoryDriverController tripHistoryDriverController =
      Get.put(TripHistoryDriverController());

  Future<void> getTrips() async {
    if (AppConstants.isCaptain) {
      tripHistoryDriverController.getTripsHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Trip History Screen");
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
              if (tripHistoryDriverController.isGettingTrips.value) {
                return Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: Get.height / 3),
                      child: const CircularProgressIndicator()),
                );
              } // add or to user
              return tripHistoryDriverController.tripsList.isEmpty
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
                        physics: const PageScrollPhysics(),
                        padding: const EdgeInsets.only(
                          top: 14,
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        itemBuilder: (context, index) {
                          String dateString = tripHistoryDriverController
                              .tripsList[index].tripDate!;
                          String time = tripHistoryDriverController
                              .tripsList[index].tripTime!;

                          String toCity = tripHistoryDriverController
                              .tripsList[index].universityName!;

                          DateTime originalDate = DateTime.parse(dateString);

                          String date =
                              DateFormat('MMM dd').format(originalDate);
                          return TripHistoryCard(
                            date: '$date  - $time',
                            fromCity: "",
                            toCity: toCity,
                            buttonText: 'rideDetails'.tr,
                            onTap: () {
                              if (AppConstants.isCaptain) {
                                Get.to(() => const CaptainTripDetailsScreen());
                              } else {
                                Get.to(() => const UserTripDetailsScreen());
                              }
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        itemCount: tripHistoryDriverController.tripsList.length,
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
