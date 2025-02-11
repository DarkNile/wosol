import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/driver_routes.dart';

import '../../models/contact_data_model.dart';
import '../../models/notification_request_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';

class DriverLayoutController extends GetxController {
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
          if ((response.data["success"] == "true")) {
            print('success');
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("ee");
      }
    }
  }

  RxList<DriverRoute> driverRoutes = <DriverRoute>[].obs;
  RxBool isGettingDriverRoutes = false.obs;

  Future<void> getDriverRoutes() async {
    isGettingDriverRoutes.value = true;
    try {
      Response response = await DioHelper.postData(
        url: 'driver/routes',
        data: {
          "driver_id": AppConstants.userRepository.driverData.driverId,
        },
      );
      if (response.statusCode == 200) {
        driverRoutes.value = List<DriverRoute>.from(response.data['data']
            .map((data) => DriverRoute.fromJson(data))
            .toList());
        isGettingDriverRoutes.value = false;
      } else {
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      throw e.response!.data['data']['error'];
    }
  }

  bool isLoading = false;

  ContactDataModel? contactDataModel;
  Future<void> getContactData() async {
    isLoading = true;
    update();
    try {
      Response response = await DioHelper.getData(
        url: 'contact_data/get_data',
      );
      if (response.statusCode == 200) {
        contactDataModel = ContactDataModel.fromJson(response.data['data']);
        isLoading = false;
        update();
      } else {
        defaultErrorSnackBar(
          context: Get.context!,
          message: response.data['data']['error'],
        );
        isLoading = false;
        update();
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    getContactData();
    super.onInit();
  }
}
