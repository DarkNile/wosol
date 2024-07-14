import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/traddy_model.dart';
import 'package:wosol/shared/constants/constants.dart';

import '../../models/notification_request_model.dart';
import '../../models/trip_list_model.dart';
import '../../shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';
import '../../view/captain_screens/driver_layout_screen.dart';

class HomeDriverController extends GetxController {
  RxBool isGettingTrips = false.obs;

  List<Trip> driverNextRide = [];
  List<Trip> driverTrips = [];

  Future<void> getTrips(BuildContext context,
      {bool containLoading = true}) async {
    driverNextRide = [];
    driverTrips = [];
    if (containLoading) {
      isGettingTrips.value = true;
    }
    try {
      Response response = await AppConstants.homeDriverRepository
          .getTrips(AppConstants.userRepository.driverData.driverId);
      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          if(response.data['data'].isNotEmpty){
            driverTrips = tripFromJson(response.data);
            // driverTrips
            //     .removeWhere((e) => e.tripType == '1' && e.students.isEmpty);
            driverNextRide = [driverTrips[0]];
            print("ssss ${driverNextRide.first.tripId}");
            driverTrips.removeAt(0);
          }

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
        // if (context.mounted) {
        //   (response.data["success"] == "false")
        //       ? defaultErrorSnackBar(
        //           context: context, message: 'generalWrongMsg'.tr)
        //       : defaultSuccessSnackBar(
        //           context: context, message: 'generalSuccessMsg'.tr);
        // }
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

  Timer? traddyTimer;
  bool traddyTripsStatesLoading = false;
  List<TraddyModel> traddyTrips = [];
  Future<void> getTraddyTripsAPI({
    required BuildContext context,
    required String tripId,
  }) async {
    traddyTripsStatesLoading = true;
    try {
      Response response =
          await AppConstants.homeDriverRepository.getTraddyTrips(
        tripId: tripId,
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          traddyTripsStatesLoading = false;
          traddyTrips = traddyTripsFromJson(response.data);
        } else {
          if (context.mounted) {
            defaultErrorSnackBar(
              context: context,
              message: response.data['data']['error'],
            );
          }
          traddyTripsStatesLoading = false;
        }
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['data']['error'],
          );
        }
        traddyTripsStatesLoading = false;
      }
    } catch (e) {
      traddyTripsStatesLoading = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
    update();
  }

  Future<void> requestRideApprovedApi({
    required String requestId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/notifications/reuqest_ride_approved',
        data: {
          "request_id": requestId,
        },
      );
      if (response.statusCode == 200) {
        defaultSuccessSnackBar(
          context: Get.context!,
          message: "generalSuccessMsg".tr,
        );
      } else {
        defaultErrorSnackBar(
          context: Get.context!,
          message: response.data['data']['error'],
        );
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
    }
  }

  Future<Response> tripEnd({
    required String tripId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/trips/trip_end',
        data: {
          "trip_id": tripId,
        },
      );
      if (response.statusCode == 200) {
        Get.offAll(() => const DriverLayoutScreen());
        defaultSuccessSnackBar(context: Get.context!, message: 'tripEnded'.tr);

        return response;
      } else {
        defaultErrorSnackBar(
          context: Get.context!,
          message: response.data['data']['error'],
        );

        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
      throw e.response!.data['data']['error'];
    }
  }
}
