import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
    return SafeArea(
      child: SizedBox(
        width: AppConstants.screenSize(context).width,
        height: AppConstants.screenSize(context).height,
        child: GetBuilder<MapController>(
            init: MapController(),
            builder: (mapController) {
              return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  GoogleMap(
                    padding: const EdgeInsets.only(bottom: 100),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: false,
                    mapType: MapType.normal,
                    trafficEnabled: true,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    initialCameraPosition: mapController.cameraPosition,
                    gestureRecognizers: {
                      Factory<PanGestureRecognizer>(() => PanGestureRecognizer(
                        allowedButtonsFilter: (i){
                          mapController.enableLocation.value = false;
                          return false;
                        }
                      )),
                      Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer(
                          allowedButtonsFilter: (i){
                            mapController.enableLocation.value = false;
                            return false;
                          }
                      )),
                    },
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
                  Obx(
              ()=> Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: (){
                                    if(!mapController.enableLocation.value){
                                      mapController.cameraToPosition(mapController.currentLatLng);
                                    }
                                    mapController.enableLocation.value = !mapController.enableLocation.value;
                                  },
                                  icon: Icon(Icons.my_location,
                                    size: 30,
                                    color: mapController.enableLocation.value? AppColors.blue : Colors.grey,
                                  )
                              ),
                              const SizedBox(width: 15,),
                            ],
                          ),
                          const SizedBox(height: 15,),
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
                                  child: students.isNotEmpty && (students.length - 1 > mapController.currentStudentIndex.value)
                                      ? Text(
                                          "${"studentName".tr}: ${students[mapController.currentStudentIndex.value].userFname} ${students[mapController.currentStudentIndex.value].userLname}",
                                          style: AppFonts.medium,
                                        )
                                      : Container(),
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
                        ],
                      ),
                    ),
                  ),

                ],
              );
            }),
      ),
    );
  }
}
