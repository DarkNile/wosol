import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:wosol/models/vehicle_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

class VehicleController extends GetxController {
  // ? =====  Get Driver Vehicles =====
  RxBool isGettingVehicles = false.obs;
  RxList<VehicleModel> vehiclesList = <VehicleModel>[].obs;
  Future<void> getDriverVehicles() async {
    try {
      log("Get Vehicles Loading");
      isGettingVehicles.value = true;
      String driverId = AppConstants.userRepository.driverData.driverId;
      Response response = await DioHelper.postData(
          url: 'driver/trips/driver_vehicle', data: {"driver_id": driverId});
      log("response ${response.data}");
      if (response.statusCode == 200) {
        vehiclesList.clear();
        List data = response.data["data"];
        vehiclesList.value =
            data.map((e) => VehicleModel.fromJson(e)).toList().obs;
        isGettingVehicles.value = false;
        log("200");
      } else {
        isGettingVehicles.value = false;
        log("error ${response.data['data']['error']}");
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingVehicles.value = false;
      log("error ${e.response!.data['data']['error']}");
      throw e.response!.data['data']['error'];
    }
  }
}
