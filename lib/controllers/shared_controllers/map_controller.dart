import 'dart:async';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/shared/services/network/repositories/map_repository.dart';

import '../../models/trip_list_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/bottom_sheets.dart';
import '../../view/captain_screens/driver_layout_screen.dart';

class MapController extends GetxController {
  MapRepository mapRepository = MapRepository();
  Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  RxInt currentStudentIndex = 0.obs;

  late CameraPosition cameraPosition;
  List<LatLng> polylineCurrentTarget = [];
  List<LatLng> polylineCurrentFinal = [];
  late LatLng currentLatLng;
  late LatLng targetLatLng;
  LatLng? finalLatLng;
  RxBool enableLocation = true.obs;

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
        if (kDebugMode) {
          print(result.errorMessage);
        }
      }
      update();
    } catch (e) {
      if (kDebugMode) {
        print("eeeeeeeeeeeeeee $e");
      }
    }
  }

  Future<void> getCurrentFinalPolylinePoints() async {
    polylineCurrentFinal = [];
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        AppConstants.googleApiKey,
        PointLatLng(currentLatLng.latitude, currentLatLng.longitude),
        PointLatLng(finalLatLng!.latitude, finalLatLng!.longitude),
      );

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCurrentFinal.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        if (kDebugMode) {
          print(result.errorMessage);
        }
      }
      update();
    } catch (e) {
      if (kDebugMode) {
        print("eeeeeeeeeeeeeee $e");
      }
    }
  }

  Future<void> cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await googleMapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: position,
      zoom: 19,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
    update();
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

  void liveLocation({
    String endLat = '',
    String endLong = '',
    String tripId = '',
    String vehicleId = '',
    List<Student> students = const [],
  }) {
    Position? previousPosition;
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      print("location");
      if (LatLng(position.latitude, position.longitude) != currentLatLng) {
        currentLatLng = LatLng(position.latitude, position.longitude);
        getCurrentTargetPolylinePoints();
        getEstimatedTime(
          originLatLng: currentLatLng,
          destinationLatLng: targetLatLng,
          students: students,
          endLat: endLat,
          endLong: endLong,
          tripId: tripId,
        );
        if(enableLocation.value) {
          cameraToPosition(currentLatLng);
        }
        if (previousPosition != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            previousPosition!.latitude,
            previousPosition!.longitude,
            position.latitude,
            position.longitude,
          );
          if (distanceInMeters >= 100) {
            mapRepository.sendLiveTracking(
              tripId: tripId,
              vehicleId: vehicleId,
              mapLat: position.latitude.toString(),
              mapLong: position.longitude.toString(),
            );

            previousPosition = position;
          }
        } else {
          previousPosition = position;
        }
      }
    });
  }

  Future<Response> tripEnd({
    required String tripId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/trips/trip_end',
        data: {
          "trip_id": tripId,
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      throw e.response!.data['data']['error'];
    }
  }

  String timeTrack = '';
  String distantTrack = '';
  bool _isEndTrip = false;
  bool _isConfirmUser = false;
  Future<void> getEstimatedTime({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
    String endLat = '',
    String endLong = '',
    String tripId = '',
    required List<Student> students,
  }) async {
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${originLatLng.latitude},${originLatLng.longitude}&destinations=${destinationLatLng.latitude},${destinationLatLng.longitude}&key=AIzaSyCa8FElw75agiPGmjxxbo8aFf5ZkvWchRw';
    final response = await DioHelper.getData(
      url: url,
    );

    if (response.statusCode == 200) {
      distantTrack =
          response.data['rows'][0]['elements'][0]['distance']['text'];
      timeTrack = response.data['rows'][0]['elements'][0]['duration']['text'];

      ///End trip bs
      if (isWithinDistance(distantTrack)) {
        if ((students.isEmpty ||
                (students.isNotEmpty &&
                    currentStudentIndex.value == students.length)) &&
            _isEndTrip == false) {
          _isEndTrip = true;
          showModalBottomSheet(
            context: Get.context!,
            builder: (context) {
              return RideAndTripEndBottomSheet(
                headTitle: 'rideEnd'.tr,
                imagePath: 'assets/images/celebrate.png',
                headerMsg: '${"congrats".tr} ',
                subHeaderMsg: 'rideCompletedSuccessfully'.tr,
                isTrip: true,
                function: () {
                  tripEnd(tripId: tripId);
                  distantTrack = "10000 km";
                  // _isEndTrip = false;
                  Get.offAll(const DriverLayoutScreen());
                },
              );
            },
          );
        } else if (_isEndTrip == false && _isConfirmUser == false) {
          _isConfirmUser = true;
          showModalBottomSheet(
            context: Get.context!,
            backgroundColor: Colors.black.withOpacity(0.3),
            builder: (context) => ConfirmPickupBottomSheet(
              title: students[currentStudentIndex.value].userFname,
              subTitle: students[currentStudentIndex.value].address,
              firstButtonFunction: () {
                AppConstants.homeDriverRepository
                    .sendTripAttendance(
                  // tripId: tripId,
                  tripId: students[currentStudentIndex.value].tripUserId,
                  userId: students[currentStudentIndex.value].userId,
                  isAttended: true,
                )
                    .then((value) async {
                  if (students.length - 1 > currentStudentIndex.value) {
                    currentStudentIndex.value++;
                    targetLatLng = LatLng(
                      double.parse(
                          students[currentStudentIndex.value].pickupLat),
                      double.parse(
                          students[currentStudentIndex.value].pickupLong),
                    );
                  } else {
                    currentStudentIndex.value++;
                    targetLatLng = LatLng(
                      double.parse(endLat),
                      double.parse(endLong),
                    );
                  }
                  update();
                  if (AppConstants.isCaptain) {
                    markerIcon = await getBytesFromAsset(
                        'assets/images/location_on.png', 70);
                    currentIcon = await getBytesFromAsset(
                        'assets/images/navigation_arrow.png', 70);
                  } else {
                    markerIcon = await getBytesFromAsset(
                        'assets/images/where_to_vote.png', 70);
                    currentIcon = await getBytesFromAsset(
                        'assets/images/person_pin_circle.png', 70);
                  }
                  await getCurrentLocation().then((value) async {
                    Get.back();
                    currentLatLng = LatLng(value.latitude, value.longitude);
                    await getCurrentTargetPolylinePoints();
                    cameraPosition = CameraPosition(
                      target: currentLatLng,
                      zoom: 12,
                    );
                    getEstimatedTime(
                      originLatLng: currentLatLng,
                      destinationLatLng: targetLatLng,
                      tripId: tripId,
                      students: students,
                      endLong: endLong,
                      endLat: endLat,
                    );
                    liveLocation();
                  });
                });
              },
              secondButtonFunction: () {
                AppConstants.homeDriverRepository
                    .sendTripAttendance(
                  tripId: tripId,
                  userId: students[currentStudentIndex.value].userId,
                  isAttended: false,
                )
                    .then((value) async {
                  if (students.length - 1 > currentStudentIndex.value) {
                    currentStudentIndex.value++;
                    targetLatLng = LatLng(
                      double.parse(
                          students[currentStudentIndex.value].pickupLat),
                      double.parse(
                          students[currentStudentIndex.value].pickupLong),
                    );
                  } else {
                    targetLatLng = LatLng(
                      double.parse(endLat),
                      double.parse(endLong),
                    );
                  }
                  if (AppConstants.isCaptain) {
                    markerIcon = await getBytesFromAsset(
                        'assets/images/location_on.png', 70);
                    currentIcon = await getBytesFromAsset(
                        'assets/images/navigation_arrow.png', 70);
                  } else {
                    markerIcon = await getBytesFromAsset(
                        'assets/images/where_to_vote.png', 70);
                    currentIcon = await getBytesFromAsset(
                        'assets/images/person_pin_circle.png', 70);
                  }
                  await getCurrentLocation().then((value) async {
                    Get.back();
                    currentLatLng = LatLng(value.latitude, value.longitude);
                    await getCurrentTargetPolylinePoints();
                    cameraPosition = CameraPosition(
                      target: currentLatLng,
                      zoom: 12,
                    );
                    getEstimatedTime(
                      originLatLng: currentLatLng,
                      destinationLatLng: targetLatLng,
                      tripId: tripId,
                      students: students,
                      endLong: endLong,
                      endLat: endLat,
                    );
                    liveLocation();
                  });
                });
              },
            ),
          );
        }
      } else {
        _isConfirmUser = false;
        _isEndTrip = false;
      }
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

bool isWithinDistance(String distanceString) {
  List<String> parts = distanceString.split(' ');
  String unit = parts[1];
  if (unit == 'm') {
    double value = double.parse(
      parts[0].replaceAll(',', ''),
    );
    if (value <= 25) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
