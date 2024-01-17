import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/widgets/shared_widgets/bottom_sheets.dart';
import 'widgets/ride_card.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeader(
          header: "Mostafa",
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
    );
  }

  Future<void> onTapRideCard(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => RideStartBottomSheet(
        firstButtonFunction: () {
          Get.back();
          showModalBottomSheet(
              context: context,
              builder: (context) => ConfirmPickupBottomSheet(
                    title: 'confirmPickup'.tr,
                    subTitle: 'canceled'.tr,
                    firstButtonFunction: () {
                      Get.back();
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => SelectUsersToPickupBottomSheet(
                                function: () {
                                  Get.back();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          _rideAndTripEndBottomSheet());
                                },
                                headTitle: 'Select users to pickup'.tr,
                                titles: const ['Hossam', 'Mostafa Ahmed'],
                                subTitles: const [
                                  'Future st, building no 13',
                                  'Future st, building no 13'
                                ],
                              ));
                    },
                    secondButtonFunction: () {
                      Get.back();
                      showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              CancellationReasonAndReportRideBottomSheet(
                                function: () {
                                  Get.back();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          (SelectUsersToPickupBottomSheet(
                                            function: () {
                                              Get.back();
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      _rideAndTripEndBottomSheet());
                                            },
                                            headTitle:
                                                'Select users to pickup'.tr,
                                            titles: const [
                                              'Hossam',
                                              'Mostafa Ahmed'
                                            ],
                                            subTitles: const [
                                              'Future st, building no 13',
                                              'Future st, building no 13'
                                            ],
                                          )));
                                },
                                headTitle: "cancelationReason".tr,
                                reasons: [
                                  "noShow".tr,
                                  "userCanceledTheTrip".tr,
                                  "canceledByCustomer".tr,
                                  'other'.tr,
                                ],
                                reasonsSelectedIndex: 3,
                              ));
                    },
                  ));
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
      headerMsg:  '${"congrats".tr} ',
      subHeaderMsg: 'rideCompletedSuccessfully'.tr,
    );
  }
}
