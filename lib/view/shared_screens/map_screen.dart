import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';

import '../../shared/constants/constants.dart';
import '../../shared/constants/style/colors.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants
          .screenSize(context)
          .width,
      height: AppConstants
          .screenSize(context)
          .height,
      child: GetBuilder<MapController>(
        init: MapController(),
          builder: (mapController) {
        return GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          initialCameraPosition: mapController.cameraPosition,
          markers: {
            Marker(
              markerId: const MarkerId('target'),
              position: mapController.targetLatLng,
              icon: BitmapDescriptor.fromBytes(mapController.markerIcon),
            ),
            Marker(
              markerId: const MarkerId('current'),
              position: mapController.currentLatLng,
              icon: BitmapDescriptor.fromBytes(mapController.currentIcon),
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
        );
      }),
    );
  }
}
