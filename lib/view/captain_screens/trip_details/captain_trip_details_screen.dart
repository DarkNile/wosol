import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/captain_widgets/user_list_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/tripDetailsCard.dart';

import '../../../models/trip_history_driver_model.dart';

class CaptainTripDetailsScreen extends StatelessWidget {
  const CaptainTripDetailsScreen({super.key, required this.dateTime, required this.from, required this.to});
  final String dateTime;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
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
                  TripDetailsCard(
                      date: dateTime,
                      fromCity:
                          from,
                      toCity:
                          to,
                      isCaptain: true),
                 // customDivider(),
                //  const UserListWidget(),
                 // customDivider(),
                 // const UserListWidget(hasSubTitle: false),
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
