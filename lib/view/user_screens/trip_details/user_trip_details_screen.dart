import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/tripDetailsCard.dart';
import 'package:wosol/view/user_screens/trip_details/widget/rate_card_widget.dart';

class UserTripDetailsScreen extends StatelessWidget {
  const UserTripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeaderWithBackButton(
          header: "tripDetails".tr,
        ),
        const SizedBox(
          height: 14,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TripDetailsCard(
                  date: 'Dec 22  - 08:10 am',
                  fromCity:
                      'Mecca Center, FR8C+HXF, At Taniem, Makkah 24224, Saudi Arabia',
                  toCity:
                      'King Abelaziz Usiversity, F6QV+J49, Unnamed Road King Abdulaziz University, Jeddah 21589, Saudi Arabia',
                  isCaptain: false,
                ),
                customDivider(),
                const RateCardWidget(),
                customDivider(),
                const RateCardWidget(
                  withRateButton: true,
                ),
                customDivider(),
                DefaultRowButton(
                    color: Colors.transparent,
                    text: 'Report a Problem'.tr,
                    textColor: AppColors.error600,
                    fontSize: 14,
                    containIcon: true,
                    svgPic: "assets/icons/flag.svg",
                    function: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget customDivider() {
    return const SizedBox(
      height: 10,
    );
  }
}
