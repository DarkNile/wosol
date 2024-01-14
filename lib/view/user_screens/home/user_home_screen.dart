import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/trips_card_widget.dart';
import '../../../shared/constants/constants.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeader(
          header: "Hossam",
          svgIcon: "",
          iconWidth: 0,
          iconHeight: 0,
          isHome: true,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                top: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "nextRide".tr,
                    style: AppFonts.header,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TripCardWidget(
                    withCancel: true,
                    withBorder: false,
                  ),
                  Padding(
                    padding: AppConstants.edge(
                      padding: const EdgeInsets.only(
                        top: 24,
                        bottom: 10,
                      ),
                    ),
                    child: Text(
                      "thisWeekTrips".tr,
                      style: AppFonts.header,
                    ),
                  ),
                  ...List.generate(
                      5,
                      (index) => const TripCardWidget(
                            withCancel: true,
                          )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
