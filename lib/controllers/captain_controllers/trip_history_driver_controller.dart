import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:wosol/models/trip_history_driver_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

import '../../models/employee_trip_history.dart';

class TripHistoryDriverController extends GetxController {
  // ? ===== Get Trips =====
  RxBool isGettingTrips = false.obs;
  RxList<TripHistoryDriverModel> tripsList = <TripHistoryDriverModel>[].obs;
  Future<void> getTripsHistory() async {
    try {
      log("Get Trips Loading");
      isGettingTrips.value = true;
      String driverId = AppConstants.userType == "Employee"
          ? AppConstants.userRepository.employeeData.driverId
          : AppConstants.userRepository.driverData.driverId;
      Response response = await DioHelper.postData(
        url: (AppConstants.userType == "Employee")
            ? "employee/trip_history"
            : 'driver/trips/trip_history',
        data: {
          if (AppConstants.userType != "Employee") "driver_id": driverId,
          if (AppConstants.userType == "Employee") "member_id": driverId,
        },
      );
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
      update();
    } on DioException catch (e) {
      isGettingTrips.value = false;
      log("error ${e.response!.data['data']['error']}");
      update();
      throw e.response!.data['data']['error'];
    }
  }

  RxList<EmployeeTrip> employeeTripsList = <EmployeeTrip>[].obs;
  Future<void> getEmployeeTripsHistory() async {
    try {
      log("Get Trips Loading");
      isGettingTrips.value = true;
      String driverId = AppConstants.userRepository.employeeData.driverId;
      Response response = await DioHelper.postData(
        url: "employee/trip_history",
        data: {
          "member_id": driverId,
        },
      );
      log("response ${response.data}");
      if (response.statusCode == 200) {
        employeeTripsList.clear();
        List data = response.data["data"];
        employeeTripsList.value = List<EmployeeTrip>.from(
          data.map((x) => EmployeeTrip.fromJson(x)),
        );
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
