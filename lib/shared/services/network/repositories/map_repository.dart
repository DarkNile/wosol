import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../../constants/constants.dart';
import '../dio_helper.dart';

class MapRepository extends GetxService {
  Future<void> sendLiveTracking({
    required String tripId,
    required String vehicleId,
    required String mapLat,
    required String mapLong,
  }) async {
    try {
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
        log("200 ${response.data}");
      } else {
        log("error ${response.data['data']['error']}");
      }
    } on DioException catch (e) {
      log("error ${e.message}");
    }
  }
}
