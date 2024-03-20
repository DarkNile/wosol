import 'package:get/state_manager.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

class TrackingDriverController extends GetxController {
  RxBool isTrackingAddLoading = false.obs;
  RxBool isTrackingAdd = false.obs;

  Future<void> trackingAdd(
      {required String tripId,
      required String vehicleId,
      required String mapLat,
      required String mapLong}) async {
    try {
      isTrackingAddLoading.value = true;
      String driverId = AppConstants.userRepository.driverData.driverId;
      Response response =
          await DioHelper.postData(url: '/driver/tracking/add', data: {
        "driver_id": driverId,
        "trip_id": tripId,
        "vehicle_id": vehicleId,
        "map_lat": mapLat,
        "map_long": mapLong
      });
      log("response ${response.data}");
      if (response.statusCode == 200) {
        isTrackingAdd.value = true;
        isTrackingAddLoading.value = false;
        log("200");
      } else {
        isTrackingAddLoading.value = false;
        log("error ${response.data['data']['error']}");
      }
    } on DioException catch (e) {
      isTrackingAddLoading.value = false;
      log("error ${e.message}");
    }
  }
}
