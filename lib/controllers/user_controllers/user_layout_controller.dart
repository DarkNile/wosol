import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/student_routes.dart';

import '../../models/student_locations.dart';
import '../../models/student_notification_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';

class UserLayoutController extends GetxController {
  RxInt navBarIndex = 0.obs;

  void changeNavBarIndexValue(int index) {
    navBarIndex.value = index;
  }

  late Timer notificationTimer;

  @override
  void onClose() {
    notificationTimer.cancel();
    super.onClose();
  }

  // ? ===== Notifications Requests =====
  StudentNotification? studentNotifications;
  Future<void> getNotificationRequests({
    required BuildContext context,
  }) async {
    try {
      await AppConstants.studentRepository
          .getStudentNotification(
        userId: AppConstants.userRepository.userData.userId,
      )
          .then((data) {
        if (data['data'].isNotEmpty) {
          studentNotifications = StudentNotification.fromJson(data['data'][0]);
        } else {
          studentNotifications = null;
        }
        update();
      });
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
    update();
  }

  RxList<TripData> studentRoutes = <TripData>[].obs;
  RxBool isGettingStudentRoutes = false.obs;

  Future<void> getStudentRoutes() async {
    isGettingStudentRoutes.value = true;
    try {
      Response response = await DioHelper.postData(
        url: 'student/routes',
        data: {
          "user_id": AppConstants.userRepository.userData.userId,
        },
      );
      if (response.statusCode == 200) {
        studentRoutes.value = List<TripData>.from(response.data['data']
            .map((data) => TripData.fromJson(data))
            .toList());
      }
      isGettingStudentRoutes.value = false;
    } on DioException catch (e) {
      isGettingStudentRoutes.value = false;
      throw e.response!.data['data']['error'];
    }

  }

  StudentLocation studentLocation = StudentLocation();
  RxBool isGettingStudentLocation = false.obs;

  Future<void> getStudentLocations() async {
    isGettingStudentLocation.value = true;
    try {
      Response response = await DioHelper.postData(
        url: 'student/locations',
        data: {
          "user_id": AppConstants.userRepository.userData.userId,
        },
      );
      if (response.statusCode == 200) {
        studentLocation = StudentLocation.fromJson(response.data);
        isGettingStudentLocation.value = false;
      } else {
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      throw e.response!.data['data']['error'];
    }
  }
}
