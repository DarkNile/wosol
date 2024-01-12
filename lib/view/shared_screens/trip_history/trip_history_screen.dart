import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';

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
              bottom: 110,
            ),
            itemBuilder: (context, index) {
              return TripHistoryCard(
                date: 'Dec 22  - 08:10 am',
                fromCity: "Mecca Center",
                toCity: " King Abdelaziz University",
                buttonText: 'rideDetails'.tr,
                onTap: () {},
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
