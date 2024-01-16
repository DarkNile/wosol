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
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => RideStartBottomSheet(
                firstButtonFunction: () {},
                headTitle: '${"rideStartWithin".tr} 59 sec',
                formTime: '10:05 am',
                toTime: '11:30 am',
                formPlace: 'Mecca ',
                toPlace: 'King Abdelaziz University',
              ),
            );
          },
          title: 'Mecca Center',
          imgPath: "assets/images/home/upcoming_ride_icon.svg",
          time: "10 mins",
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
            physics: const BouncingScrollPhysics(),
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
}
