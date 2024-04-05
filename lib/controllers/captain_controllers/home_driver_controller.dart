import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/shared/constants/constants.dart';

import '../../models/notification_request_model.dart';
import '../../models/trip_list_model.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';

class HomeDriverController extends GetxController {
  late Timer notificationTimer;

  // @override
  // void onInit() {
  //   super.onInit();
  //   startNotificationTimer();
  // }

  @override
  void onClose() {
    notificationTimer.cancel();
    super.onClose();
  }

  void startNotificationTimer() {
    notificationTimer = Timer.periodic(const Duration(minutes: 3), (timer) {
      getNotificationRequests(context: Get.context!);
    });
  }

  RxBool isGettingTrips = false.obs;

  List<Trip> driverNextRide = [];
  List<Trip> driverTrips = [];

  Future<void> getTrips(BuildContext context) async {
    isGettingTrips.value = true;
    try {
      Response response = await AppConstants.homeDriverRepository
          .getTrips(AppConstants.userRepository.driverData.driverId);
      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {

          driverTrips = tripFromJson(response.data);
          driverNextRide = [driverTrips[0]];
          driverTrips.removeAt(0);
          isGettingTrips.value = false;
        } else {
          if (context.mounted) {
            defaultErrorSnackBar(
              context: context,
              message: response.data['data']['error'],
            );
          }
          isGettingTrips.value = false;
        }
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['data']['error'],
          );
        }
        isGettingTrips.value = false;
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      isGettingTrips.value = false;
    }
    update();
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
  List<NotificationRequestModel> notificationRequests = [];
  Future<void> getNotificationRequests({
    required BuildContext context,
  }) async {
    try {
      await AppConstants.homeDriverRepository
          .getNotificationRequests(
        driverId: AppConstants.userRepository.driverData.driverId,
      )
          .then((response) {
        notificationRequests = notificationFromJson(response.data);
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
