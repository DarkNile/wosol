import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:wosol/models/trip_history_driver_model.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

class TripHistoryDriverController extends GetxController {
  // ? ===== Get Trips =====
  RxBool isGettingTrips = false.obs;
  RxList<TripHistoryDriverModel> tripsList = <TripHistoryDriverModel>[].obs;
  Future<void> getTripsHistory() async {
    try {
      log("Get Trips Loading");
      isGettingTrips.value = true;
      Response response = await DioHelper.postData(
          url: 'driver/trips/trip_history', data: {"driver_id": "27"});
      log("response ${response.data}");
      if (response.statusCode == 200) {
        tripsList.clear();
        List data = response.data["data"];
        tripsList.value =
            data.map((e) => TripHistoryDriverModel.fromJson(e)).toList().obs;
        isGettingTrips.value = false;
        log("200");
      } else {
        isGettingTrips.value = false;
        log("error ${response.data['data']['error']}");
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingTrips.value = false;
      log("error ${e.response!.data['data']['error']}");
      throw e.response!.data['data']['error'];
    }
  }
}
