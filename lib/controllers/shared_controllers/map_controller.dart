import 'dart:async';
import 'dart:ui' as ui;
import 'dart:math' as Math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/shared/services/network/repositories/map_repository.dart';
import 'package:wosol/view/captain_screens/driver_layout_screen.dart';

import '../../models/trip_list_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/bottom_sheets.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';
import '../captain_controllers/home_driver_controller.dart';

class MapController extends GetxController {
  MapRepository mapRepository = MapRepository();
  Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  RxInt currentStudentIndex = 0.obs;

  late CameraPosition cameraPosition;
  List<LatLng> polylineCurrentTarget = [];
  // List<LatLng> polylineCurrentFinal = [];
  LatLng? previousLatLng;
  late LatLng currentLatLng;
  late LatLng targetLatLng;
  late LatLng startLatLng;
  // LatLng? finalLatLng;
  RxBool enableLocation = true.obs;
  bool isToEnd = false;
  // Timer? timer;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentTargetPolylinePoints({bool drawNormal = true}) async {
    polylineCurrentTarget = [];
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      late PolylineResult result;
      if (drawNormal) {
        result = await polylinePoints.getRouteBetweenCoordinates(
          AppConstants.googleApiKey,
          PointLatLng(currentLatLng.latitude, currentLatLng.longitude),
          PointLatLng(targetLatLng.latitude, targetLatLng.longitude),
          travelMode: TravelMode.driving,
        );
      } else {
        result = await polylinePoints.getRouteBetweenCoordinates(
          AppConstants.googleApiKey,
          PointLatLng(startLatLng.latitude, startLatLng.longitude),
          PointLatLng(targetLatLng.latitude, targetLatLng.longitude),
          travelMode: TravelMode.driving,
        );
      }

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCurrentTarget.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        if (kDebugMode) {
          debugPrint(result.errorMessage);
        }
      }
      update();
    } catch (e) {
      if (kDebugMode) {
        debugPrint("eeeeeeeeeeeeeee $e");
      }
    }
  }

  // Future<void> getCurrentFinalPolylinePoints() async {
  //   polylineCurrentFinal = [];
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   try {
  //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       AppConstants.googleApiKey,
  //       PointLatLng(currentLatLng.latitude, currentLatLng.longitude),
  //       PointLatLng(finalLatLng!.latitude, finalLatLng!.longitude),
  //     );
  //
  //     if (result.points.isNotEmpty) {
  //       for (var point in result.points) {
  //         polylineCurrentFinal.add(LatLng(point.latitude, point.longitude));
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print(result.errorMessage);
  //       }
  //     }
  //     update();
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("eeeeeeeeeeeeeee $e");
  //     }
  //   }
  // }

  Future<void> cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await googleMapController.future;

    CameraPosition newCameraPosition = CameraPosition(
      target: position,
      zoom: cameraPosition.zoom,
    );
    cameraPosition = newCameraPosition;

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

  void userLiveLocation(
      {bool getEstimatedTime = true, bool drawCurrentTargetPolyline = true}) {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      if (LatLng(position.latitude, position.longitude) != currentLatLng) {
        currentLatLng = LatLng(position.latitude, position.longitude);
        if (drawCurrentTargetPolyline) {
          getCurrentTargetPolylinePoints();
        }
        if (getEstimatedTime) {
          userGetEstimatedTime(
              originLatLng: currentLatLng, destinationLatLng: targetLatLng);
        }
        cameraToPosition(currentLatLng);
        update();
      }
    });
  }

  Future<void> userGetEstimatedTime({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
  }) async {
    debugPrint("caaaaallll");
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${originLatLng.latitude},${originLatLng.longitude}&destinations=${destinationLatLng.latitude},${destinationLatLng.longitude}&key=AIzaSyCa8FElw75agiPGmjxxbo8aFf5ZkvWchRw';
    final response = await DioHelper.getData(
      url: url,
    );

    if (response.statusCode == 200) {
      distantTrack =
          response.data['rows'][0]['elements'][0]['distance']['text'];
      timeTrack = response.data['rows'][0]['elements'][0]['duration']['text'];
      debugPrint("ressponseeee ${response.data}");
    } else {
      throw Exception('Failed to load place details');
    }
    update();
  }

  String currentTripId = "";
  String currentEndLat = "";
  String currentEndLong = "";
  String currentVehicleId = "";
  List<Student> currentStudents = const [];
  bool currentIsEmployee = false;
  bool currentIsStudent = false;
  bool currentIsRound = false;
  bool isFirstTripType = false;
  StreamSubscription<Position>? positionStream;
  int liveTrackingDistance = 0;
  void liveLocation({
    String endLat = '',
    String endLong = '',
    String tripId = '',
    String vehicleId = '',
    List<Student> students = const [],
    required bool isEmployee,
    required bool isStudent,
    required bool isRound,
    required bool firstTripType,
  }) {
    HomeDriverController homeDriverController = Get.put(HomeDriverController());
    debugPrint("from liveee locationnnn  $tripId");
// defaultSuccessSnackBar(
//       context: Get.context!,
//       message: "From Live Location Trip Id: $tripId",
//     );
    Position? previousPosition;
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      isStudent = currentIsStudent;
      tripId = currentTripId;
      endLat = currentEndLat;
      endLong = currentEndLong;
      vehicleId = currentVehicleId;
      isEmployee = currentIsEmployee;
      isRound = currentIsRound;
      firstTripType = isFirstTripType;
      if(isRound == false && isStudent){
        homeDriverController
            .getTrips(Get.context!, containLoading: false)
            .then((v) {
          print("------- ${currentStudentIndex}");
          if (homeDriverController.driverNextRide.isNotEmpty) {
            currentStudents = homeDriverController.driverNextRide[0].students;
            if (currentStudents.isNotEmpty) {
              targetLatLng = LatLng(double.parse(currentStudents[0].pickupLat),
                  double.parse(currentStudents[0].pickupLong));
              currentStudentIndex.value = 0;
            } else {
              currentStudentIndex.value = -1;
            }
          }
        });
      }else{
        currentStudents = homeDriverController.driverNextRide[0].students;
      }
      students = currentStudents;
      for (var student in currentStudents) {
        print("studenttt ${student.userLname}");
      }
      debugPrint(
          "posotitotnn $position --- $tripId -- $currentTripId -- currentOndex ${currentStudentIndex} -- ");
      liveTrackingDistance += 100;
      if (LatLng(position.latitude, position.longitude) != currentLatLng) {
        previousLatLng = currentLatLng;
        currentLatLng = LatLng(position.latitude, position.longitude);

        update();
        getCurrentTargetPolylinePoints();
        debugPrint("geee estimateddd one $tripId");
        getEstimatedTime(
            isEmployee: isEmployee,
            isStudent: isStudent,
            firstTripType: firstTripType,
            originLatLng: currentLatLng,
            destinationLatLng: targetLatLng,
            students: students,
            endLat: endLat,
            endLong: endLong,
            tripId: tripId,
            isRound: isRound);
        if (enableLocation.value) {
          cameraToPosition(currentLatLng);
        }
        if (liveTrackingDistance == 3000) {
          liveTrackingDistance = 0;
          if (previousPosition != null) {
            double distanceInMeters = Geolocator.distanceBetween(
              previousPosition!.latitude,
              previousPosition!.longitude,
              position.latitude,
              position.longitude,
            );
            print("sssss #{distanceInMeters ${distanceInMeters}");
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
        positionStream!.cancel();
        positionStream = null;
        Get.offAll(() => const DriverLayoutScreen());
        defaultSuccessSnackBar(context: Get.context!, message: 'tripEnded'.tr);

        return response;
      } else {
        defaultErrorSnackBar(
          context: Get.context!,
          message: response.data['data']['error'],
        );

        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
      throw e.response!.data['data']['error'];
    }
  }

  Future<Response> nearbyStudent({
    required String driverId,
    required String tripId,
    required String userId,
    required String tripUserId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/trips/trip_near_student',
        data: {
          "driver_id": driverId,
          "trip_id": tripId,
          "user_id": userId,
          "trip_user_id": tripUserId
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

  Future<void> reachStartPointApi({
    required String tripId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/trips/trip_reach_start',
        data: {
          "trip_id": tripId,
        },
      );
      if (response.statusCode == 200) {
        defaultSuccessSnackBar(
          context: Get.context!,
          message: "startPointSBMsg".tr,
        );
      } else {
        defaultErrorSnackBar(
          context: Get.context!,
          message: response.data['data']['error'],
        );
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
    }
  }

  String timeTrack = '';
  String distantTrack = '';
  bool _isEndTrip = false;
  bool _isConfirmUser = false;
  double bearing = 0;
  Future<void> getEstimatedTime({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
    String endLat = '',
    String endLong = '',
    String tripId = '',
    required bool isEmployee,
    required bool isStudent,
    required bool isRound,
    required List<Student> students,
    required bool firstTripType,
  }) async {
    HomeDriverController homeDriverController = Get.put(HomeDriverController());

    debugPrint("geetttt estimateddd $tripId");
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${originLatLng.latitude},${originLatLng.longitude}&destinations=${destinationLatLng.latitude},${destinationLatLng.longitude}&key=AIzaSyCa8FElw75agiPGmjxxbo8aFf5ZkvWchRw';
    final response = await DioHelper.getData(
      url: url,
    );

    if (response.statusCode == 200) {
      distantTrack =
          response.data['rows'][0]['elements'][0]['distance']['text'];
      timeTrack = response.data['rows'][0]['elements'][0]['duration']['text'];

      // defaultSuccessSnackBar(
      //   context: Get.context!,
      //   message: "From Get Estimated Time Trip Id: $tripId",
      // );
      debugPrint("iusss yo enddd ${isToEnd}");

      ///End trip bs
      ///
      if (isWithinDistance(distantTrack)) {
        print("isToEnd ${isToEnd}");
        print("currenttttt ${currentStudentIndex}");
        print("student list: ${students.isEmpty}");
        if (isEmployee && !isToEnd) {
          isToEnd = true;
          showModalBottomSheet(
              context: Get.context!,
              isDismissible: false,
              enableDrag: false,
              builder: (context) {
                return RandomSheet(
                  headTitle: "startPoint".tr,
                  subTitle: "${"startPointMsg".tr} *Trip id: $tripId",
                  function: () {
                    reachStartPointApi(
                      tripId: tripId,
                    );
                    Get.back();
                    // timer = Timer(const Duration(seconds: 10), () {
                    //   _isEndTrip = true;
                    //   showModalBottomSheet(
                    //     context: Get.context!,
                    //     isDismissible: false,
                    //     enableDrag: false,
                    //     builder: (context) {
                    //       return RideAndTripEndBottomSheet(
                    //         headTitle: 'rideEnd'.tr,
                    //         imagePath: 'assets/images/celebrate.png',
                    //         headerMsg: '${"congrats".tr} ',
                    //         subHeaderMsg:
                    //             "${'rideCompletedSuccessfully'.tr} *Trip id: $tripId",
                    //         isTrip: true,
                    //         function: () async {
                    //           await tripEnd(tripId: tripId);
                    //           distantTrack = "10000 km";
                    //           // isToEnd = false;
                    //           // _isEndTrip = false;
                    //           // homeDriverController.getTrips(context);
                    //         },
                    //       );
                    //     },
                    //   );
                    // });
                  },
                );
              });
          print("------- ${currentStudentIndex}");
          targetLatLng = LatLng(
            double.parse(endLat),
            double.parse(endLong),
          );
          update();
        } else if (((students.isEmpty && isToEnd) ||
                ((students.isEmpty && currentStudentIndex.value == -1 && isRound == false) || (students.isNotEmpty &&
                    currentStudentIndex.value == students.length && isRound == true))) &&
            _isEndTrip == false && firstTripType) {
          _isEndTrip = true;
          showModalBottomSheet(
            context: Get.context!,
            isDismissible: false,
            enableDrag: false,
            builder: (context) {
              return RideAndTripEndBottomSheet(
                headTitle: 'rideEnd'.tr,
                imagePath: 'assets/images/celebrate.png',
                headerMsg: '${"congrats".tr} ',
                subHeaderMsg:
                    "${'rideCompletedSuccessfully'.tr} *Trip id: $tripId",
                isTrip: true,
                function: () async {
                  await tripEnd(tripId: tripId);
                  distantTrack = "10000 km";
                  if (positionStream != null) {
                    positionStream!.cancel();
                    positionStream = null;
                  }
                  // isToEnd = false;
                  // _isEndTrip = false;
                  // homeDriverController.getTrips(context);
                },
              );
            },
          );
        } else if (_isEndTrip == false &&
            _isConfirmUser == false &&
            isRound == false) {
          _isConfirmUser = true;
          showModalBottomSheet(
            context: Get.context!,
            isDismissible: false,
            enableDrag: false,
            backgroundColor: Colors.black.withOpacity(0.3),
            builder: (bottomContext) => ConfirmPickupBottomSheet(
              title: students[currentStudentIndex.value].isStartPoint? 'studentTrip'.tr : students[currentStudentIndex.value].userFname,
              subTitle: students[currentStudentIndex.value].isStartPoint? 'waitStudentsMsg'.tr :  students[currentStudentIndex.value].address,
              firstButtonFunction: () {
                AppConstants.homeDriverRepository
                    .sendTripAttendance(
                  tripId: tripId,
                  userId: students[currentStudentIndex.value].tripUserId,
                  isAttended: true,
                  isStartPoint: students[currentStudentIndex.value].isStartPoint,
                )
                    .then((value) async {
                  homeDriverController
                      .getTrips(Get.context!, containLoading: false)
                      .then((v) async {
                    if (homeDriverController.driverNextRide.isNotEmpty) {
                      currentStudents =
                          homeDriverController.driverNextRide[0].students;
                      if (currentStudents.isNotEmpty) {
                        targetLatLng = LatLng(
                            double.parse(currentStudents[0].pickupLat),
                            double.parse(currentStudents[0].pickupLong));
                        currentStudentIndex.value = 0;
                        nearbyStudent(
                          driverId:
                              AppConstants.userRepository.driverData.driverId,
                          tripId: tripId,
                          userId: students[currentStudentIndex.value].userId,
                          tripUserId:
                              students[currentStudentIndex.value].tripUserId,
                        );
                      } else {
                        if(firstTripType) {
                          targetLatLng =
                              LatLng(
                                  double.parse(endLat), double.parse(endLong));
                          currentStudentIndex.value = -1;
                        } else {
                          showModalBottomSheet(
                            context: Get.context!,
                            isDismissible: false,
                            enableDrag: false,
                            builder: (endContext) {
                              return RideAndTripEndBottomSheet(
                                headTitle: 'rideEnd'.tr,
                                imagePath: 'assets/images/celebrate.png',
                                headerMsg: '${"congrats".tr} ',
                                subHeaderMsg:
                                "${'rideCompletedSuccessfully'.tr} *Trip id: $tripId",
                                isTrip: true,
                                function: () async {
                                  await tripEnd(tripId: tripId);
                                  distantTrack = "10000 km";
                                  if (positionStream != null) {
                                    positionStream!.cancel();
                                    positionStream = null;
                                  }
                                  // isToEnd = false;
                                  // _isEndTrip = false;
                                  // homeDriverController.getTrips(context);
                                },
                              );
                            },
                          );
                        }
                      }
                    }

                    // if (students.length - 1 > currentStudentIndex.value) {
                    //   // currentStudentIndex.value++;
                    //
                    //   targetLatLng = LatLng(
                    //     double.parse(
                    //         students[currentStudentIndex.value].pickupLat),
                    //     double.parse(
                    //         students[currentStudentIndex.value].pickupLong),
                    //   );
                    // } else {
                    //   currentStudentIndex.value++;
                    //   targetLatLng = LatLng(
                    //     double.parse(endLat),
                    //     double.parse(endLong),
                    //   );
                    // }
                    update();

                    markerIcon = await getBytesFromAsset(
                        'assets/images/location_on.png', 70);
                    currentIcon = await getBytesFromAsset(
                        'assets/images/navigation_arrow.png', 70);

                    await getCurrentLocation().then((value) async {
                      if (Navigator.of(bottomContext).canPop()) {
                        Navigator.of(bottomContext).pop();
                      }
                      currentLatLng = LatLng(value.latitude, value.longitude);
                      await getCurrentTargetPolylinePoints();
                      cameraPosition = CameraPosition(
                        target: currentLatLng,
                        zoom: 12,
                      );
                      debugPrint("geee estimateddd 2 $tripId");
                      getEstimatedTime(
                          isEmployee: isEmployee,
                          isStudent: isStudent,
                          firstTripType: firstTripType,
                          originLatLng: currentLatLng,
                          destinationLatLng: targetLatLng,
                          tripId: tripId,
                          students: students,
                          endLong: endLong,
                          endLat: endLat,
                          isRound: isRound);
                      debugPrint("live stresaaaam  6$tripId");
                      liveLocation(
                        isEmployee: isEmployee,
                        isStudent: isStudent,
                        firstTripType: firstTripType,
                        isRound: isRound,
                      );
                    });
                  });
                });
              },
              secondButtonFunction: () {
                AppConstants.homeDriverRepository
                    .sendTripAttendance(
                  tripId: tripId,
                  userId: students[currentStudentIndex.value].tripUserId,
                  isAttended: false,
                  isStartPoint: students[currentStudentIndex.value].isStartPoint
                )
                    .then((value) async {
                  if (students.isNotEmpty) {
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
                  markerIcon = await getBytesFromAsset(
                      'assets/images/location_on.png', 70);
                  currentIcon = await getBytesFromAsset(
                      'assets/images/navigation_arrow.png', 70);
                  await getCurrentLocation().then((value) async {
                    if (Navigator.of(bottomContext).canPop()) {
                      Navigator.of(bottomContext).pop();
                    }
                    currentLatLng = LatLng(value.latitude, value.longitude);
                    await getCurrentTargetPolylinePoints();
                    cameraPosition = CameraPosition(
                      target: currentLatLng,
                      zoom: 12,
                    );
                    debugPrint("geee estimateddd 3 $tripId");
                    getEstimatedTime(
                        isEmployee: isEmployee,
                        isStudent: isStudent,
                        firstTripType: firstTripType,
                        originLatLng: currentLatLng,
                        destinationLatLng: targetLatLng,
                        tripId: tripId,
                        students: students,
                        endLong: endLong,
                        endLat: endLat,
                        isRound: isRound);
                    debugPrint("live stresaaaam 5 $tripId");

                    liveLocation(isEmployee: isEmployee, isRound: isRound, isStudent: isStudent, firstTripType: firstTripType,);
                  });
                });
              },
            ),
          );
        } else if (_isEndTrip == false &&
            _isConfirmUser == false &&
            isRound == true) {
          _isConfirmUser = true;
          if(students[currentStudentIndex.value].isStartPoint){
            RandomSheet(
              headTitle: "employeesTrip".tr,
              subTitle: "waitEmployeeMsg".tr,
              function: () {
                Get.back();
              },
            );
          }
          if (students.length - 1 > currentStudentIndex.value) {
            currentStudentIndex.value++;
            // nearbyStudent(
            //   driverId: AppConstants.userRepository.driverData.driverId,
            //   tripId: tripId,
            //   userId: students[currentStudentIndex.value].userId,
            //   tripUserId:
            //   students[currentStudentIndex.value].tripUserId,
            // );
            targetLatLng = LatLng(
              double.parse(students[currentStudentIndex.value].pickupLat),
              double.parse(students[currentStudentIndex.value].pickupLong),
            );
          } else {
            if(firstTripType) {
              currentStudentIndex.value++;
              targetLatLng = LatLng(
                double.parse(endLat),
                double.parse(endLong),
              );
            } else {
              showModalBottomSheet(
                context: Get.context!,
                isDismissible: false,
                enableDrag: false,
                builder: (context) {
                  return RideAndTripEndBottomSheet(
                    headTitle: 'rideEnd'.tr,
                    imagePath: 'assets/images/celebrate.png',
                    headerMsg: '${"congrats".tr} ',
                    subHeaderMsg:
                    "${'rideCompletedSuccessfully'.tr} *Trip id: $tripId",
                    isTrip: true,
                    function: () async {
                      await tripEnd(tripId: tripId);
                      distantTrack = "10000 km";
                      if (positionStream != null) {
                        positionStream!.cancel();
                        positionStream = null;
                      }
                      // isToEnd = false;
                      // _isEndTrip = false;
                      // homeDriverController.getTrips(context);
                    },
                  );
                },
              );
            }
          }
          update();

          markerIcon =
              await getBytesFromAsset('assets/images/location_on.png', 70);
          currentIcon =
              await getBytesFromAsset('assets/images/navigation_arrow.png', 70);

          await getCurrentLocation().then((value) async {
            // Get.back();
            currentLatLng = LatLng(value.latitude, value.longitude);
            await getCurrentTargetPolylinePoints();
            cameraPosition = CameraPosition(
              target: currentLatLng,
              zoom: 12,
            );
            debugPrint("geee estimateddd 4 $tripId");
            getEstimatedTime(
                isEmployee: isEmployee,
                isStudent: isStudent,
                firstTripType: firstTripType,
                originLatLng: currentLatLng,
                destinationLatLng: targetLatLng,
                tripId: tripId,
                students: students,
                endLong: endLong,
                endLat: endLat,
                isRound: isRound);
            debugPrint("live stresaaaam 4 $tripId");
            liveLocation(
              isEmployee: isEmployee,
              isStudent: isStudent,
              firstTripType: firstTripType,
              isRound: isRound,
            );
          });
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
  Uint8List? startIcon;
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

  double calculateBearing(LatLng startPoint, LatLng endPoint) {
    final double startLat = toRadians(startPoint.latitude);
    final double startLng = toRadians(startPoint.longitude);
    final double endLat = toRadians(endPoint.latitude);
    final double endLng = toRadians(endPoint.longitude);

    final double deltaLng = endLng - startLng;

    final double y = Math.sin(deltaLng) * Math.cos(endLat);
    final double x = Math.cos(startLat) * Math.sin(endLat) -
        Math.sin(startLat) * Math.cos(endLat) * Math.cos(deltaLng);

    final double bearing = Math.atan2(y, x);

    return (toDegrees(bearing) + 360) % 360;
  }

  double toRadians(double degrees) {
    return degrees * (Math.pi / 180.0);
  }

  double toDegrees(double radians) {
    return radians * (180.0 / Math.pi);
  }
}

bool isWithinDistance(String distanceString) {
  List<String> parts = distanceString.split(' ');
  String unit = parts[1];
  if (unit == 'm') {
    double value = double.parse(
      parts[0].replaceAll(',', ''),
    );
    if (value <= 100) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
