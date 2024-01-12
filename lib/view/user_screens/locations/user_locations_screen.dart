import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

import '../../../shared/constants/style/colors.dart';
import '../../../shared/widgets/shared_widgets/trip_history_card.dart';

class UserLocationsScreen extends StatelessWidget {
  const UserLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderWithBackButton(
              header: "locations".tr,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  top: 18,
                  left: 16,
                  right: 16,
                ),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => TripHistoryCard(
                  height: 236,
                  date: 'date',
                  fromCity: "from",
                  toCity: "to",
                  onTap: () {},
                  buttonText: "viewOnMap".tr,
                  middleWidget: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 1.0),
                        child: Icon(
                          Icons.location_on_rounded,
                          size: 16,
                          color: AppColors.darkBlue300,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "mecca center, FR8C+HXF, At taniem, makkah 24224, Saudi Arabia",
                          style: AppFonts.small.copyWith(
                            color: AppColors.darkBlue300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
