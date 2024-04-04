import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';

import '../../models/notification_request_model.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';

class HomeDriverController extends GetxController {
  late Timer _notificationTimer;

  @override
  void onInit() {
    print("On Init");
    super.onInit();
    startNotificationTimer();
  }

  @override
  void onClose() {
    _notificationTimer.cancel();
    super.onClose();
  }

  void startNotificationTimer() {
    print("Start NotificationTimer");
    _notificationTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      try {
        print("Notification");
        getNotificationRequests(context: Get.context!);
      } catch (e) {
        print("Error getting $e");
      }
    });
  }

  Future<void> getTrips() async {
    AppConstants.homeDriverRepository.getTrips();
  }

  // ? ===== Trip States API =====
  RxBool tripStatesLoading = false.obs;
  Future<void> tripStatesAPI({
    required BuildContext context,
    required String tripId,
    String? tripUserId,
    String? attendance,
    required int state,
  }) async {
    tripStatesLoading.value = true;
    try {
      await AppConstants.homeDriverRepository
          .tripStates(
        tripId: tripId,
        tripUserId: tripUserId,
        attendance: attendance,
        state: state,
      )
          .then((response) {
        tripStatesLoading.value = false;
        Get.back();
        if (context.mounted) {
          (response.data["success"] == "false")
              ? defaultErrorSnackBar(
                  context: context, message: 'generalWrongMsg'.tr)
              : defaultSuccessSnackBar(
                  context: context, message: 'generalSuccessMsg'.tr);
        }
      });
    } catch (e) {
      tripStatesLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  // ? ===== Notifications Requests =====
  NotificationRequestModel notificationRequestData =
      NotificationRequestModel.empty();
  Future<void> getNotificationRequests({
    required BuildContext context,
  }) async {
    try {
      await AppConstants.homeDriverRepository
          .getNotificationRequests(
        driverId: AppConstants.userRepository.driverData.driverId,
      )
          .then((response) {
        notificationRequestData =
            NotificationRequestModel.fromJson(response.data);
        if (notificationRequestData.requestId.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Notification Requests'),
                content: Text(
                    'You have request from ${notificationRequestData.employeeName}.'),
                actions: <Widget>[
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          approveRequestFromNotification(
                            context: context,
                            requestId: notificationRequestData.requestId,
                          );
                        },
                        child: const Text('Accept'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      });
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> approveRequestFromNotification({
    required BuildContext context,
    required String requestId,
  }) async {
    try {
      await AppConstants.homeDriverRepository
          .approveNotificationRequests(
        requestId: requestId,
      )
          .then((response) {
        if (context.mounted) {
          if ((response.data["success"] == "true")) {}
        }
      });
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }
}
