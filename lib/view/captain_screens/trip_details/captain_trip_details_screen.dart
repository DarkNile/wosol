import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/captain_widgets/user_list_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/tripDetailsCard.dart';

class CaptainTripDetailsScreen extends StatelessWidget {
  const CaptainTripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderWithBackButton(
              header: "tripDetails".tr,
            ),
            Expanded(
              child: ListView(
                physics: const PageScrollPhysics(),
                children: [
                  const TripDetailsCard(
                      date: 'Dec 22  - 08:10 am',
                      fromCity:
                          'Mecca Center, FR8C+HXF, At Taniem, Makkah 24224, Saudi Arabia',
                      toCity:
                          'King Abelaziz Usiversity, F6QV+J49, Unnamed Road King Abdulaziz University, Jeddah 21589, Saudi Arabia',
                      isCaptain: true),
                  customDivider(),
                  const UserListWidget(),
                  customDivider(),
                  const UserListWidget(hasSubTitle: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customDivider() {
    return const SizedBox(
      height: 10,
    );
  }
}
