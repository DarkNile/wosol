import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

import '../../../controllers/captain_controllers/home_driver_controller.dart';
import '../../shared_screens/map_screen.dart';

class TraddyTripsScreen extends StatefulWidget {
  const TraddyTripsScreen({
    super.key,
    required this.homeDriverController,
    required this.mapController,
    required this.tripId,
    required this.fromLatLng,
    required this.toLatLng,
  });

  final HomeDriverController homeDriverController;
  final MapController mapController;
  final String tripId;
  final LatLng fromLatLng;
  final LatLng toLatLng;

  @override
  State<TraddyTripsScreen> createState() => _TraddyTripsScreenState();
}

class _TraddyTripsScreenState extends State<TraddyTripsScreen> {
  @override
  void initState() {
    widget.homeDriverController.traddyTimer =
        Timer.periodic(const Duration(seconds: 30), (timer) {
      if (context.mounted) {
        widget.homeDriverController
            .getTraddyTripsAPI(context: context, tripId: widget.tripId);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.homeDriverController.traddyTimer!.cancel();
    widget.homeDriverController.traddyTimer = null;
    super.dispose();
  }

  void openGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final Uri googleMapUri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(googleMapUri)) {
      await launchUrl(googleMapUri);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomHeaderWithBackButton(
              header: "traddyTrips".tr,
              isTraddy: true,
              onBackPressed: () {
                Navigator.pop(context, true);
              },
              traddyFunction: () async {
                widget.mapController.markerIcon =
                await widget.mapController.getBytesFromAsset(
                    'assets/images/location_on.png', 50);
                widget.mapController.startIcon =
                await widget.mapController.getBytesFromAsset(
                    'assets/images/location_on.png', 50);
                widget.mapController.currentIcon =
                await widget.mapController.getBytesFromAsset(
                    'assets/images/navigation_arrow.png', 50);
                widget.mapController.startLatLng = widget.fromLatLng;
                widget.mapController.targetLatLng = widget.toLatLng;

                await widget.mapController.getCurrentLocation().then((value) async {
                  widget.mapController.currentLatLng =
                      LatLng(value.latitude, value.longitude);
                  await widget.mapController.getCurrentTargetPolylinePoints(drawNormal: false);
                  widget.mapController.cameraPosition = CameraPosition(
                    target: widget.mapController.currentLatLng,
                    bearing: widget.mapController.bearing,
                    zoom: 19,
                  );
                  widget.mapController.userLiveLocation(getEstimatedTime: false, drawCurrentTargetPolyline: false);
                  Get.to(() => const MapScreen(
                    students: [],
                    isTraddy: true,
                  ));
                });
              },
            ),
            GetBuilder<HomeDriverController>(
              builder: (context) {
                return Expanded(
                  child: widget.homeDriverController.traddyTrips.isEmpty
                      ? Center(
                          child: Text(
                            'waitTheTrips'.tr,
                            style: AppFonts.header,
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 16),
                          itemBuilder: (context, index) => Container(
                            width: Get.width,
                            height: 135,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.white900,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                  color: AppColors.black.withOpacity(0.15),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            '${'name'.tr}:  ',
                                            style: AppFonts.header
                                                .copyWith(fontSize: 16),
                                          ),
                                          Text(
                                            widget.homeDriverController
                                                .traddyTrips[index].employeeName,
                                            style: AppFonts.medium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            '${'Phone Number'.tr}:  ',
                                            style: AppFonts.header
                                                .copyWith(fontSize: 16),
                                          ),
                                          Text(
                                            widget.homeDriverController
                                                .traddyTrips[index].employeePhone,
                                            style: AppFonts.medium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${'Email'.tr}:  ',
                                        style:
                                            AppFonts.header.copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        widget.homeDriverController
                                            .traddyTrips[index].employeeEmail,
                                        style: AppFonts.medium,
                                      ),
                                    ],
                                  ),
                                ),
                                DefaultButton(
                                  function: () {
                                    widget.homeDriverController
                                        .requestRideApprovedApi(
                                            requestId: widget.homeDriverController
                                                .traddyTrips[index].requestId)
                                        .then((value) => openGoogleMaps(
                                            double.parse(widget.homeDriverController
                                                .traddyTrips[index].lat),
                                            double.parse(widget.homeDriverController
                                                .traddyTrips[index].lng)));
                                  },
                                  height: 40,
                                  text: 'approve'.tr,
                                )
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                          itemCount: widget.homeDriverController.traddyTrips.length,
                        ),
                );
              }
            ),
            DefaultButton(
              function: () async{
                await widget.homeDriverController.tripEnd(tripId: widget.tripId);
                widget.mapController.positionStream!.cancel();
                widget.mapController.startIcon = null;
              },
              marginBottom: 16,
              marginTop: 16,
              marginLeft: 16,
              marginRight: 16,
              color: AppColors.darkBlueGrey,
              height: 48,
              text: 'endTrip'.tr,
            )
          ],
        ),
      ),
    );
  }
}
