import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/view/captain_screens/trip_details/captain_trip_details_screen.dart';
import 'package:wosol/view/user_screens/trip_details/user_trip_details_screen.dart';

import '../../../shared/widgets/shared_widgets/custom_header.dart';
import '../../../shared/widgets/shared_widgets/trip_history_card.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeaderWithOptionalWidget(
          screenTitle: "tripsHistory".tr,
          suffixWidget: IconButton(
            padding: AppConstants.edge(
              padding: const EdgeInsets.only(right: 16),
            ),
            onPressed: () {},
            icon: SvgPicture.asset("assets/images/filter_icon.svg"),
          ),
          isWithBackArrow: false,
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              top: 13,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            itemBuilder: (context, index) {
              return TripHistoryCard(
                date: 'Dec 22  - 08:10 am',
                fromCity: "Mecca Center",
                toCity: " King Abdelaziz University",
                buttonText: 'rideDetails'.tr,
                onTap: () {
                  if(AppConstants.isCaptain) {
                    Get.to(() => const CaptainTripDetailsScreen());
                  }else{
                    Get.to(() => const UserTripDetailsScreen());
                  }
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 12,
            ),
            itemCount: 5,
          ),
        )
      ],
    );
  }
}
