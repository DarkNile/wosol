import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controllers/captain_controllers/driver_layout_controller.dart';
import '../../../controllers/captain_controllers/home_driver_controller.dart';
import '../../../controllers/shared_controllers/map_controller.dart';
import '../../../models/trip_list_model.dart';
import '../../../view/shared_screens/map_screen.dart';
import '../../constants/constants.dart';
import '../../constants/style/colors.dart';
import '../../constants/style/fonts.dart';

class NotificationRideRequest extends StatelessWidget {
  const NotificationRideRequest({
    super.key,
    required this.driverLayoutController,
    required this.mapController,
    required this.trip,
  });

  final DriverLayoutController driverLayoutController;
  final MapController mapController;
  final Trip trip;

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
                    if (AppConstants.userType == 'Driver') {
                      mapController.markerIcon =
                          await mapController.getBytesFromAsset(
                              'assets/images/location_on.png', 70);
                      mapController.currentIcon =
                          await mapController.getBytesFromAsset(
                              'assets/images/navigation_arrow.png', 70);
                    }
                    await mapController
                        .getCurrentLocation()
                        .then((value) async {
                      mapController.currentLatLng =
                          LatLng(value.latitude, value.longitude);
                      await mapController.getCurrentTargetPolylinePoints();
                      mapController.cameraPosition = CameraPosition(
                        target: mapController.currentLatLng,
                        zoom: 14,
                      );
                      mapController.targetLatLng = LatLng(double.parse(trip.toLat), double.parse(trip.toLong));
                      mapController.getEstimatedTime(
                        originLatLng: mapController.currentLatLng,
                        destinationLatLng: mapController.targetLatLng,
                        students: trip.students,
                        tripId: trip.tripId,
                        endLat: trip.toLat,
                        endLong: trip.toLong,
                        isEmployee: trip.tripType ==
                            '3',
                        isStudent: trip.tripType ==
                            '1',
                        isRound: trip.coType == 'round' ? true : false,
                      );
                      mapController.currentTripId = trip.tripId;
                      mapController.currentStudentIndex.value = 0;
                      mapController.currentEndLat = trip.toLat;
                      mapController.currentEndLong = trip.toLong;
                      mapController.currentVehicleId = trip.vehicleId;
                      mapController.currentStudents = trip.students;
                      mapController.currentIsEmployee = trip.tripType == '3';
                      mapController.currentIsStudent = trip.tripType == '1';
                      mapController.currentIsRound = trip.coType == 'round' ? true : false;
                      mapController.liveLocation(
                        students: trip.students,
                        tripId: trip.tripId,
                        endLat: trip.toLat,
                        endLong: trip.toLong,
                        vehicleId: trip.vehicleId,
                        isEmployee: trip.tripType ==
                        '3',
                        isStudent: trip.tripType ==
                            '1',
                        isRound: trip.coType == 'round' ? true : false,
                      );
                    });

                    Get.back();
                    Get.to(() => MapScreen(
                          students: trip.students,
                      isRound: trip.coType == 'round' ? true : false,
                        ));
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
