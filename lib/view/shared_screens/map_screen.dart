import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

import '../../models/trip_list_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/constants/style/colors.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    super.key,
    required this.students,
  });
  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.screenSize(context).width,
      height: AppConstants.screenSize(context).height,
      child: GetBuilder<MapController>(
          init: MapController(),
          builder: (mapController) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  initialCameraPosition: mapController.cameraPosition,
                  markers: {
                    Marker(
                      markerId: const MarkerId('target'),
                      position: mapController.targetLatLng,
                      icon:
                          BitmapDescriptor.fromBytes(mapController.markerIcon),
                    ),
                    Marker(
                      markerId: const MarkerId('current'),
                      position: mapController.currentLatLng,
                      icon:
                          BitmapDescriptor.fromBytes(mapController.currentIcon),
                    ),
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('CT'),
                      points: mapController.polylineCurrentTarget,
                      color: AppColors.blue,
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    mapController.googleMapController.complete(controller);
                  },
                ),
                Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            spreadRadius: 3,
                            color: AppColors.black.withOpacity(0.10),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                          child: Text(
                            "${"studentName".tr}: ${students[mapController.currentStudentIndex.value].userFname} ${students[mapController.currentStudentIndex.value].userLname}",
                            style: AppFonts.medium,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.offWhite,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColors.black)),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_rounded,
                                    color: AppColors.black,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    mapController.timeTrack,
                                    style: AppFonts.header,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.offWhite,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColors.black)),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.black,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    mapController.distantTrack,
                                    style: AppFonts.header,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
