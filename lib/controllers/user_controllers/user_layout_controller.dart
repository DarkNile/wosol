import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/student_notification_model.dart';
import '../../shared/constants/constants.dart';
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
  List<StudentNotification> studentNotifications = [];
  Future<void> getNotificationRequests({
    required BuildContext context,
  }) async {
    try {
      await AppConstants.studentRepository
          .getStudentNotification(
        userId: AppConstants.userRepository.userData.userId,
      )
          .then((data) {
        studentNotifications = data["data"].map((data) => StudentNotification.fromJson(data)).toList();
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

}
