import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/constants/constants.dart';
import '../../shared/widgets/shared_widgets/bottom_sheets.dart';

class MapController extends GetxController{
  Completer<GoogleMapController> googleMapController =
  Completer<GoogleMapController>();

  late CameraPosition cameraPosition;
  List<LatLng> polylineCurrentTarget = [];
  late LatLng currentLatLng;
  late LatLng targetLatLng;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentTargetPolylinePoints() async{
    polylineCurrentTarget = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AppConstants.googleApiKey,
      PointLatLng(currentLatLng.latitude, currentLatLng.longitude),
      PointLatLng(targetLatLng.latitude, targetLatLng.longitude),
    );
    if(result.points.isNotEmpty){
      for (var point in result.points) {
        polylineCurrentTarget.add(
            LatLng(point.latitude, point.longitude)
        );
      }
    }else{
      print(result.errorMessage);
    }
    update();
  }

  Future<void> cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await googleMapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: position,
      zoom: 12,
    );
    await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition),);
  }

  Future<Position> getCurrentLocation() async{
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      return Future.error('Location Services Are Disable');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location Services Are Disable');
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error('Location Services Are Permanently Denied, We Cannot Request Permission For The Location');
    }

    update();
    return await Geolocator.getCurrentPosition();
  }

  void liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      if(LatLng(position.latitude, position.longitude) != currentLatLng){
        currentLatLng = LatLng(position.latitude, position.longitude);
        getCurrentTargetPolylinePoints();
        cameraToPosition(currentLatLng);
        update();
      }
    });
  }

  late Uint8List markerIcon;
  late Uint8List currentIcon;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}