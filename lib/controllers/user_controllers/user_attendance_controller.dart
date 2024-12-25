import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/user_attendance_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';
import 'package:wosol/shared/widgets/shared_widgets/snakbar.dart';

class UserAttendanceController extends GetxController {
  // ? ===== Get User Attendance =====
  RxBool isGettingUseAttendance = false.obs;
  RxList<UserAttendanceModel> userAttendanceList = <UserAttendanceModel>[].obs;
  Future<void> getUserAttendance() async {
    try {
      log("Get User Attendance Loading");
      isGettingUseAttendance.value = true;
      String userId = AppConstants.userRepository.userData.userId;
      Response response = await DioHelper.postData(
          url: 'student/attendance', data: {"user_id": userId});
      log("response ${response.data}");
      if (response.statusCode == 200) {
        userAttendanceList.clear();
        List data = response.data["data"];
        userAttendanceList.value =
            data.map((e) => UserAttendanceModel.fromJson(e)).toList().obs;
        isGettingUseAttendance.value = false;
        log("200");
      } else {
        isGettingUseAttendance.value = false;
        log("error ${response.data['data']['error']}");
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingUseAttendance.value = false;
      log("e ${e.message.toString()}");
      defaultErrorSnackBar(
          context: Get.context!, message: e.message ?? "Error");
      // log("error ${e.response!.data['data']['error']}");
      // throw e.response!.data['data']['error'];
    }
  }

  @override
  void onInit() {
    getUserAttendance();
    super.onInit();
  }
}
