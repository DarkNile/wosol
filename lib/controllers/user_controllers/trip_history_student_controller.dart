import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:wosol/models/trip_history_student_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

class TripHistoryStudentController extends GetxController {
  // ? ===== Get Trips =====
  RxBool isGettingTrips = false.obs;
  RxList<TripHistoryStudentModel> tripsList = <TripHistoryStudentModel>[].obs;
  Future<void> getTripsHistory() async {
    try {
      log("Get Trips Loading");
      isGettingTrips.value = true;
      String userId = AppConstants.userRepository.userData.userId;
      Response response = await DioHelper.postData(
          url: 'student/trip_history', data: {"user_id": userId});
      log("response ${response.data}");
      print("response ${response.data}");
      if (response.statusCode == 200) {
        tripsList.clear();
        List data = response.data["data"];
        tripsList.value =
            data.map((e) => TripHistoryStudentModel.fromJson(e)).toList().obs;
        isGettingTrips.value = false;
        log("200");
      } else {
        isGettingTrips.value = false;
        log("error ${response.data['data']['error']}");
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingTrips.value = false;
      log("e ${e.message.toString()}");
      // log("error ${e.response!.data['data']['error']}");
      // throw e.response!.data['data']['error'];
    }
  }
}
