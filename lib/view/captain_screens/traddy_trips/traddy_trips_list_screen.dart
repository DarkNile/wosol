import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

import '../../../controllers/captain_controllers/home_driver_controller.dart';

class TraddyTripsScreen extends StatefulWidget {
  const TraddyTripsScreen({
    super.key,
    required this.homeDriverController,
    required this.tripId,
  });

  final HomeDriverController homeDriverController;
  final String tripId;

  @override
  State<TraddyTripsScreen> createState() => _TraddyTripsScreenState();
}

class _TraddyTripsScreenState extends State<TraddyTripsScreen> {
  @override
  void initState() {
    widget.homeDriverController.traddyTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      widget.homeDriverController.getTraddyTripsAPI(context: context, tripId: widget.tripId);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomHeaderWithBackButton(
              header: "traddyTrips".tr,
              onBackPressed: () {
                Navigator.pop(context, true);
              },
            ),
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  itemBuilder: (context, index) => Container(),
                  separatorBuilder: (context, index) => const SizedBox(height: 12,),
                  itemCount: widget.homeDriverController.traddyTrips.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
