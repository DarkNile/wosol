import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/report_reasons_model.dart';
import 'package:wosol/models/trip_history_student_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

import '../../shared/widgets/shared_widgets/bottom_sheets.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';
import '../captain_controllers/trip_history_driver_controller.dart';

class TripHistoryStudentController extends GetxController {
  double tripRate = -1;
  double vehicleRate = -1;
  double driverRate = -1;

  TextEditingController tripRateController = TextEditingController();
  TextEditingController vehicleRateController = TextEditingController();
  TextEditingController driverRateController = TextEditingController();

  RxBool addRateLoading = false.obs;
  Future<void> addRate({
    required String userId,
    required String tripId,
    required String tripUserId,
    required String tripType,
}) async {
    addRateLoading.value = true;
    update();
    try {
      if(tripRate != -1 || driverRate != -1 || vehicleRate != -1){
        Response response = await DioHelper.postData(
            url: 'rate_trip/add',
            data: {
              "trip_id" : tripId,
              "trip_user_id" : tripUserId,
              "trip_type" : tripType,
              "user_id" : userId,

              "trip_stars" : tripRate,
              "trip_comment" : tripRateController.text,

              "driver_id" : "",
              "driver_stars" : driverRate,
              "driver_comment" : driverRateController.text,

              "vehicle_id" : "",
              "vehicle_stars" : vehicleRate,
              "vehicle_comment" : vehicleRateController.text,
            }
        );
        if (response.statusCode == 200) {
          addRateLoading.value = false;
          Get.back();
          if (AppConstants.userType == "Employee") {
            final TripHistoryDriverController tripHistoryDriverController =
            Get.find();
            tripHistoryDriverController.getEmployeeTripsHistory();
          } else {
            getTripsHistory();
          }
          showModalBottomSheet(
              context: Get.context!,
              isDismissible: false,
              enableDrag: false,
              builder: (context) => RideCanceledAndReportedBottomSheet(
                  headTitle: 'Ride Reported'.tr,
                  imagePath: 'assets/images/star.png',
                  headerMsg: 'Rated submitted successfully'.tr,
                  subHeaderMsg:
                  'Thank you, hope you have enjoyed your ride with us'
                      .tr,
                  isReportFirstStep: true));
          update();
        } else {
          defaultErrorSnackBar(
            context: Get.context!,
            message: response.data['data']['error'],
          );
          addRateLoading.value = false;
          update();
        }
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
      addRateLoading.value = false;
      update();
    }
  }

  RxBool isGettingReportReasons = false.obs;
  ReportReasonsModel? reportReasonsModel;
  ReportReasons? selectedReportReason;
  TextEditingController reportController = TextEditingController();
  Future<void> getReportReasons() async {
    isGettingReportReasons.value = true;
    selectedReportReason = null;
    reportController.clear();
    update();
    try {
      Response response = await DioHelper.getData(
        url: 'report_data/listing',
      );
      if (response.statusCode == 200) {
        reportReasonsModel = ReportReasonsModel.fromJson(response.data);
        isGettingReportReasons.value = false;
        update();
      } else {
        defaultErrorSnackBar(
          context: Get.context!,
          message: response.data['data']['error'],
        );
        isGettingReportReasons.value = false;
        update();
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
      isGettingReportReasons.value = false;
      update();
    }
  }

  RxBool addReportLoading = false.obs;
  Future<void> addReport({
    required String userId,
    required String tripId,
    required String tripUserId,
    required String tripType,
  }) async {
    addReportLoading.value = true;
    update();
    try {
      if(selectedReportReason != null){
        Response response = await DioHelper.postData(
            url: 'report_data/add',
            data: {
              "trip_id" : tripId,
              "trip_user_id" : tripUserId,
              "trip_type" : tripType,
              "user_id" : userId,

              "report_data_id" : selectedReportReason!.reportId,
              "report_comment" : reportController.text,
            }
        );
        if (response.statusCode == 200) {
          addReportLoading.value = false;
          Get.back();
          Get.back();
          if (AppConstants.userType == "Employee") {
            final TripHistoryDriverController tripHistoryDriverController =
            Get.find();
            tripHistoryDriverController.getEmployeeTripsHistory();
          } else {
            getTripsHistory();
          }
          showModalBottomSheet(
              context: Get.context!,
              isDismissible: false,
              enableDrag: false,
              builder: (context) => RideCanceledAndReportedBottomSheet(
                  headTitle: 'Ride Reported'.tr,
                  imagePath: 'assets/images/sad.png',
                  headerMsg: 'We feel sorry for you'.tr,
                  subHeaderMsg:
                  'We received your report successfully, and we will try to resolve the issue very soon.'
                      .tr,
                  isReportFirstStep: true));
          update();
        } else {
          defaultErrorSnackBar(
            context: Get.context!,
            message: response.data['data']['error'],
          );
          addReportLoading.value = false;
          update();
        }
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
      addReportLoading.value = false;
      update();
    }
  }

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
