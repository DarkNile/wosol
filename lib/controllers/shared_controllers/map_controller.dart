import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/shared/services/network/repositories/map_repository.dart';

import '../../shared/constants/constants.dart';
import '../../shared/services/network/dio_helper.dart';

class MapController extends GetxController {
  MapRepository mapRepository = MapRepository();
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

  Future<void> getCurrentTargetPolylinePoints() async {
    polylineCurrentTarget = [];
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        AppConstants.googleApiKey,
        PointLatLng(currentLatLng.latitude, currentLatLng.longitude),
        PointLatLng(targetLatLng.latitude, targetLatLng.longitude),
      );

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCurrentTarget.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        print(result.errorMessage);
      }
      update();
    } catch (e) {
      print("eeeeeeeeeeeeeee $e");
    }
  }

  Future<void> cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await googleMapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: position,
      zoom: 12,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location Services Are Disable');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Services Are Disable');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location Services Are Permanently Denied, We Cannot Request Permission For The Location');
    }
    update();
    return await Geolocator.getCurrentPosition();
  }

  void liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      if (LatLng(position.latitude, position.longitude) != currentLatLng) {
        currentLatLng = LatLng(position.latitude, position.longitude);
        getCurrentTargetPolylinePoints();
        getEstimatedTime(
            originLatLng: currentLatLng, destinationLatLng: targetLatLng);
        cameraToPosition(currentLatLng);
        update();
        mapRepository.sendLiveTracking(
          tripId: "27",
          vehicleId: "1",
          mapLat: position.latitude.toString(),
          mapLong: position.longitude.toString(),
        );
      }
    });
  }

  String timeTrack = '';
  String distantTrack = '';
  Future<void> getEstimatedTime({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
  }) async {
    print("caaaaallll");
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${originLatLng.latitude},${originLatLng.longitude}&destinations=${destinationLatLng.latitude},${destinationLatLng.longitude}&key=AIzaSyCa8FElw75agiPGmjxxbo8aFf5ZkvWchRw';
    final response = await DioHelper.getData(
      url: url,
    );

    if (response.statusCode == 200) {
      distantTrack =
          response.data['rows'][0]['elements'][0]['distance']['text'];
      timeTrack = response.data['rows'][0]['elements'][0]['duration']['text'];
      print("ressponseeee ${response.data}");
    } else {
      throw Exception('Failed to load place details');
    }
    update();
  }

  late Uint8List markerIcon;
  late Uint8List currentIcon;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
