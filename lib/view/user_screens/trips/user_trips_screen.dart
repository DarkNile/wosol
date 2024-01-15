import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

import '../../../shared/constants/style/fonts.dart';
import '../../../shared/widgets/shared_widgets/trips_card_widget.dart';

class UserTripsScreen extends StatelessWidget {
  const UserTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderWithBackButton(header: "trips".tr),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "start".tr,
                      style: AppFonts.header,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 24,
                      ),
                      child: TripCardWidget(),
                    ),
                    Text(
                      "return".tr,
                      style: AppFonts.header,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TripCardWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
