import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/shared/constants/constants.dart';

class MapRoutesScreen extends StatefulWidget {
  const MapRoutesScreen({
    super.key,
    required this.fromLatLng,
    required this.toLatLng,
  });

  final LatLng fromLatLng;
  final LatLng toLatLng;

  @override
  State<MapRoutesScreen> createState() => MapRoutesScreenState();
}

class MapRoutesScreenState extends State<MapRoutesScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: AppConstants.screenWidth(context),
          height: AppConstants.screenHeight(context),
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                markers: {
                  Marker(
                    markerId: const MarkerId("fromLat"),
                    position: widget.fromLatLng,
                  ),
                  Marker(
                    markerId: const MarkerId("toLat"),
                    position: widget.toLatLng,
                  ),
                },
                polygons: {
                  Polygon(
                    strokeWidth: 4,
                    polygonId: const PolygonId("routes"),
                    points: [
                      widget.fromLatLng,
                      widget.toLatLng,
                    ],
                  ),
                },
                initialCameraPosition: CameraPosition(
                  target: widget.fromLatLng,
                  zoom: 8,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              BackButton(),
            ],
          ),
        ),
      ),
    );
  }
}
