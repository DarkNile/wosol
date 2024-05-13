import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/view/captain_screens/driver_layout_screen.dart';

import '../../controllers/captain_controllers/home_driver_controller.dart';
import '../../models/trip_list_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/constants/style/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.students,
  });
  final List<Student> students;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = Get.put<MapController>(MapController());
  final HomeDriverController homeDriverController =
      Get.put(HomeDriverController());
  @override
  void initState() {
    super.initState();
    KeepScreenOn.turnOn();
  }

  @override
  void dispose() {
    super.dispose();
    KeepScreenOn.turnOff();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: AppConstants.isCaptain,
      onPopInvoked: (v) {
        if (AppConstants.isCaptain) {
          homeDriverController.getTrips(context);
        }
      },
      child: SafeArea(
        child: SizedBox(
          width: AppConstants.screenSize(context).width,
          height: AppConstants.screenSize(context).height,
          child: GetBuilder<MapController>(builder: (mapController) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GoogleMap(
                  padding: const EdgeInsets.only(bottom: 100),
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  initialCameraPosition: mapController.cameraPosition,
                  gestureRecognizers: {
                    Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer(allowedButtonsFilter: (i) {
                              mapController.enableLocation.value = false;
                              return false;
                            })),
                    Factory<ScaleGestureRecognizer>(
                        () => ScaleGestureRecognizer(allowedButtonsFilter: (i) {
                              mapController.enableLocation.value = false;
                              return false;
                            })),
                  },
                  markers: {
                    // if(mapController.finalLatLng != null)
                    // Marker(
                    //   markerId: const MarkerId('final'),
                    //   position: mapController.finalLatLng!,
                    //   icon:
                    //   BitmapDescriptor.fromBytes(mapController.markerIcon),
                    // ),
                    Marker(
                      markerId: const MarkerId('target'),
                      position: mapController.targetLatLng,
                      icon:
                          BitmapDescriptor.fromBytes(mapController.markerIcon),
                    ),
                    Marker(
                      markerId: const MarkerId('current'),
                      position: mapController.currentLatLng,
                      rotation: mapController.previousLatLng != null
                          ? mapController.calculateBearing(
                              mapController.previousLatLng!,
                              mapController.currentLatLng)
                          : 90,
                      icon:
                          BitmapDescriptor.fromBytes(mapController.currentIcon),
                      anchor: const Offset(0.5, 0.5),
                    )
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('CT'),
                      points: mapController.polylineCurrentTarget,
                      color: AppColors.blue,
                    ),
                    // if(mapController.polylineCurrentFinal.isNotEmpty)
                    //   Polyline(
                    //     polylineId: const PolylineId('CF'),
                    //     points: mapController.polylineCurrentFinal,
                    //     color: AppColors.blue,
                    //   ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    mapController.googleMapController.complete(controller);
                  },
                ),
                Obx(
                  () => Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (!mapController.enableLocation.value) {
                                    mapController.cameraToPosition(
                                        mapController.currentLatLng);
                                  }
                                  mapController.enableLocation.value =
                                      !mapController.enableLocation.value;
                                },
                                icon: Icon(
                                  Icons.my_location,
                                  size: 30,
                                  color: mapController.enableLocation.value
                                      ? AppColors.blue
                                      : Colors.grey,
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8),
                                child: widget.students.isNotEmpty &&
                                        (widget.students.length - 1 >
                                            mapController
                                                .currentStudentIndex.value)
                                    ? Text(
                                        "${"studentName".tr}: ${widget.students[mapController.currentStudentIndex.value].userFname} ${widget.students[mapController.currentStudentIndex.value].userLname}",
                                        style: AppFonts.medium,
                                      )
                                    : Container(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.offWhite,
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: AppColors.black)),
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
                                        border:
                                            Border.all(color: AppColors.black)),
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
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
