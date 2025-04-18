import 'package:get/state_manager.dart';
import 'package:wosol/models/notification_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

class NotificationController extends GetxController {
  RxBool isNotificationsLoading = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  Future<void> getNotifications() async {
    try {
      isNotificationsLoading.value = true;
      String driverId = AppConstants.userRepository.driverData.driverId;
      String employeeId = AppConstants.userRepository.employeeData.driverId;
      String userId = AppConstants.userRepository.userData.userId;
      Response response = AppConstants.userType == 'Driver'
          ? await DioHelper.postData(url: 'driver/notifications/view', data: {
              "driver_id": driverId,
            })
          : AppConstants.userType == 'Employee'
              ? await DioHelper.postData(url: 'employee/notifications', data: {
                  "member_id": employeeId,
                })
              : await DioHelper.postData(
                  url: 'student/notifications/view',
                  data: {"user_id": userId});
      log("response ${response.data}");
      if (response.statusCode == 200) {
        log("200");
        List data = response.data['data'];
        isNotificationsLoading.value = false;
        notifications.value =
            data.map((e) => NotificationModel.fromJson(e)).toList().obs;
      } else {
        isNotificationsLoading.value = false;
      }
    } on DioException catch (e) {
      isNotificationsLoading.value = false;
      log("error ${e.message}");
    }
  }

  var notificationRead = false.obs;
  var isNotificationSetReadLoading = false.obs;
  Future<void> notificationSetRead({required String notificationId}) async {
    try {
      isNotificationSetReadLoading.value = true;
      Response response = AppConstants.userType == 'Driver'
          ? await DioHelper.postData(
              url: 'driver/notifications/set_read',
              data: {"n_id": notificationId})
          : AppConstants.userType == 'Employee'
              ? await DioHelper.postData(
                  url: 'employee/notifications/set_read',
                  data: {"n_id": notificationId})
              : await DioHelper.postData(
                  url: 'student/notifications/set_read',
                  data: {"n_id": notificationId});
      log("response ${response.data}");
      if (response.statusCode == 200) {
        log("200");
        isNotificationSetReadLoading.value = false;
        notificationRead.value = true;
        getNotifications();
      } else {
        isNotificationSetReadLoading.value = false;
      }
    } on DioException catch (e) {
      isNotificationSetReadLoading.value = false;
      log("error ${e.message}");
    }
  }
}
