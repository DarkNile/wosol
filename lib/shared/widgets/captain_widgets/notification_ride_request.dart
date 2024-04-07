import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controllers/captain_controllers/driver_layout_controller.dart';
import '../../../controllers/shared_controllers/map_controller.dart';
import '../../../view/shared_screens/map_screen.dart';
import '../../constants/constants.dart';
import '../../constants/style/colors.dart';
import '../../constants/style/fonts.dart';

class NotificationRideRequest extends StatelessWidget {
  const NotificationRideRequest({
    super.key,
    required this.driverLayoutController,
    required this.mapController,
  });

  final DriverLayoutController driverLayoutController;
  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ride Requests",
              style: AppFonts.header,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'You have request from ${driverLayoutController.notificationRequests.first.employeeName}.',
              style: AppFonts.button.copyWith(
                color: AppColors.blueGray,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    'Accept',
                    style: AppFonts.header.copyWith(
                      color: AppColors.btnEditColor,
                    ),
                  ),
                  onPressed: () async {
                    driverLayoutController.approveRequestFromNotification(
                      context: context,
                      requestId: driverLayoutController
                          .notificationRequests.first.requestId,
                    );
                    mapController.targetLatLng = LatLng(
                      double.parse(driverLayoutController
                          .notificationRequests.first.mapLat),
                      double.parse(
                        driverLayoutController
                            .notificationRequests.first.mapLong,
                      ),
                    );
                    if (AppConstants.isCaptain) {
                      mapController.markerIcon =
                          await mapController.getBytesFromAsset(
                              'assets/images/location_on.png', 70);
                      mapController.currentIcon =
                          await mapController.getBytesFromAsset(
                              'assets/images/navigation_arrow.png', 70);
                    } else {
                      mapController.markerIcon =
                          await mapController.getBytesFromAsset(
                              'assets/images/where_to_vote.png', 70);
                      mapController.currentIcon =
                          await mapController.getBytesFromAsset(
                              'assets/images/person_pin_circle.png', 70);
                    }
                    await mapController
                        .getCurrentLocation()
                        .then((value) async {
                      mapController.currentLatLng =
                          LatLng(value.latitude, value.longitude);
                      // mapController.currentLatLng =
                      //     const LatLng(24.7136, 46.6753);
                      await mapController.getCurrentTargetPolylinePoints();
                      mapController.cameraPosition = CameraPosition(
                        target: mapController.currentLatLng,
                        zoom: 12,
                      );
                      mapController.getEstimatedTime(
                          originLatLng: mapController.currentLatLng,
                          destinationLatLng: mapController.targetLatLng,
                      tripId: driverLayoutController
                          .notificationRequests.first.tripId,
                        endLat: driverLayoutController
                            .notificationRequests.first.mapLat,
                        endLong: driverLayoutController
                            .notificationRequests.first.mapLong,
                        students: [],
                      );
                      mapController.liveLocation();
                    });
                    Get.back();
                    Get.to(() => const MapScreen());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
