import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/cancel_reasons_model.dart';
import 'package:wosol/models/trip_list_model.dart';
import 'package:wosol/models/trip_model.dart';

import '../../models/calendar_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/bottom_sheets.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';
import '../shared_controllers/map_controller.dart';

class UserHomeController extends GetxController {
  List<CalendarData> calendarData = [];
  RxBool isGettingCalendar = false.obs;

  Future<void> getCalendarData() async {
    isGettingCalendar.value = true;
    try {
      String userId = AppConstants.userRepository.userData.userId;
      Response response = await DioHelper.postData(
        url: 'student/calendar',
        data: {"user_id": userId},
      );
      if (response.statusCode == 200) {
        calendarData.clear();
        isGettingCalendar.value = false;
        calendarData = CalendarModel.fromJson(response.data).data ?? [];
      } else {
        isGettingCalendar.value = false;
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingCalendar.value = false;
      throw e.response!.data['data']['error'];
    }
  }

  // ? ===== Get Trips =====
  RxBool isGettingTrips = false.obs;
  RxList<TripModel> tripsList = <TripModel>[].obs;
  Future<void> getTrips({bool containLoading = true}) async {
    try {
      log("Get Trips Loading");
      if(containLoading) {
        isGettingTrips.value = true;
      }
      String userId = AppConstants.userRepository.userData.userId;
      // var token = await CacheHelper.getData(key: 'token');
      Response response = await DioHelper.postData(
          url: 'student/trips',
          // data: {'user_id': token, "trip_id": tripId},
          data: {"user_id": userId});
      log("response ${response.data}");
      if (response.statusCode == 200) {
        tripsList.clear();
        List data = response.data["data"];
        tripsList.value = data.map((e) => TripModel.fromJson(e)).toList().obs;
        isGettingTrips.value = false;
        log("200");
      } else {
        isGettingTrips.value = false;
        log("error ${response.data['data']['error']}");
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingTrips.value = false;
      log("error ${e.response!.data['data']['error']}");
      throw e.response!.data['data']['error'];
    }
  }

  // ? ===== Get Trip Info =====
  RxBool isGettingTripInfo = false.obs;
  RxList<TripModel> tripInfo = <TripModel>[].obs;
  Future<void> getTripInfo({required String tripId}) async {
    try {
      isGettingTripInfo.value = true;
      String userId = AppConstants.userRepository.userData.userId;
      // var token = await CacheHelper.getData(key: 'token');
      Response response = await DioHelper.postData(
          url: 'student/trips/trip_info',
          // data: {'user_id': token, "trip_id": tripId},
          data: {"user_id": userId, "trip_id": "30"});
      if (response.statusCode == 200) {
        List data = response.data["data"];
        tripInfo.value = data.map((e) => TripModel.fromJson(e)).toList().obs;
        isGettingTripInfo.value = false;
      } else {
        isGettingTripInfo.value = false;
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingTripInfo.value = false;
      throw e.response!.data['data']['error'];
    }
  }

  // ? ===== Trip Cancel API =====
  RxBool tripCancelLoading = false.obs;
  Future<void> tripCancelAPI({
    required BuildContext context,
    required String tripUserId,
    required String userId,
    required String tripId,
    required String cancel,
    required Student? student,
    String? cancelReason,
  }) async {
    tripCancelLoading.value = true;
    try {
      await AppConstants.studentRepository
          .tripCancel(
        tripUserId: tripUserId,
        userId: userId,
        tripId: tripId,
        cancel: cancel,
        cancelReasonId: selectedReasons?.reasonId,
        cancelReason: cancelReason,
      )
          .then((response) {
            selectedReasons = null;
        tripCancelLoading.value = false;
        Get.back();
        getTrips();
        final MapController mapController = Get.find();
        if (context.mounted) {
          if(cancel != "0"){
            if(student != null){
              mapController.leftStudents.remove(student);
              mapController.canceledStudents.add(student);
              mapController.update();
            }
            defaultSuccessSnackBar(
                context: context, message: 'Trip Canceled'.tr);
          } else{
            if(student != null){
              mapController.canceledStudents.remove(student);
              mapController.leftStudents.add(student);
              mapController.update();
            }
            defaultSuccessSnackBar(
                context: context, message: 'Trip Un Canceled'.tr);
          }

        }
      });
    } catch (e) {
      tripCancelLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  // ? ===== Trip Cancel By Date API =====
  RxBool tripCancelByDateLoading = false.obs;
  Future<void> tripCancelByDateAPI({
    required BuildContext context,
    required String date,
    required String userId,
    required String cancel,
    String? cancelReason,
  }) async {
    tripCancelByDateLoading.value = true;
    try {
      await AppConstants.studentRepository
          .cancelByDate(
        endPoint: cancelReason == null
            ? '/student/trips/un_cancel_trip_by_date'
            : '/student/trips/cancel_trip_user_by_date',
        date: date,
        userId: userId,
        cancel: cancel,
        cancelReason: cancelReason,
      )
          .then((response) {
        log("Trip Cancel By Date API statusCode ${response.statusCode}");
        log("response ${response.data}");
        tripCancelByDateLoading.value = false;
        if (response.statusCode == 200) {
          Get.back();
          showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              builder: (context) => RideCanceledAndReportedBottomSheet(
                    isCancel: !(cancel == "0"),
                    headTitle: !(cancel == "0")
                        ? 'Ride Canceled'.tr
                        : 'Ride UnCanceled'.tr,
                    isReportFirstStep: true,
                    imagePath: 'assets/images/smile.png',
                    headerMsg: !(cancel == "0")
                        ? 'Ride has been canceled'.tr
                        : 'Ride has been un canceled'.tr,
                    subHeaderMsg:
                        "Thank you for being kind and save others' time.".tr,
                  ));
          if (context.mounted) {
            !(cancel == "0")
                ? defaultSuccessSnackBar(
                    context: context, message: 'Trip Canceled'.tr)
                : defaultSuccessSnackBar(
                    context: context, message: 'Trip Un Canceled'.tr);
          }
          getTrips();
        }
      });
    } catch (e) {
      tripCancelByDateLoading.value = false;
      log("e ${e.toString()}");
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
    update();
  }

  // ? ===== Calendar Cancel API =====
  RxBool calendarCancelLoading = false.obs;
  Future<void> calendarCancelAPI({
    required BuildContext context,
    required String calendarId,
    required String userId,
    required String cancel,
    String? cancelReason,
  }) async {
    calendarCancelLoading.value = true;
    try {
      await AppConstants.studentRepository
          .calendarCancel(
        calendarId: calendarId,
        userId: userId,
        cancel: cancel,
        cancelReason: cancelReason,
      )
          .then((response) {
        calendarCancelLoading.value = false;
        Get.back();
        if (context.mounted) {
          !(cancel == "0")
              ? defaultErrorSnackBar(
                  context: context, message: 'Trip Canceled'.tr)
              : defaultSuccessSnackBar(
                  context: context, message: 'Trip Un Canceled'.tr);
        }
      });
    } catch (e) {
      calendarCancelLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  // ? ===== Calendar Cancel By Date API =====
  RxBool calendarCancelByDateLoading = false.obs;
  Future<void> calendarCancelByDateAPI({
    required BuildContext context,
    required String date,
    required String userId,
    required String cancel,
    String? cancelReason,
  }) async {
    calendarCancelByDateLoading.value = true;
    try {
      await AppConstants.studentRepository
          .cancelByDate(
        endPoint: cancelReason == null
            ? 'student/calendar/calendar_un_cancel_by_date'
            : 'student/calendar/calendar_cancel_by_date',
        date: date,
        userId: userId,
        cancel: cancel,
        cancelReasonId: selectedReasons?.reasonId,
        cancelReason: cancelReason,
      )
          .then((response) {
        calendarCancelByDateLoading.value = false;
        if (response.statusCode == 200) {
          Get.back();
          getCalendarData();
          if(context.mounted) {
            showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              builder: (context) => RideCanceledAndReportedBottomSheet(
                    headTitle: 'Ride Canceled'.tr,
                    isReportFirstStep: true,
                    imagePath: 'assets/images/smile.png',
                    headerMsg: 'Ride has been canceled'.tr,
                    subHeaderMsg:
                        "Thank you for being kind and save others' time.".tr,
                  ));
          }
          if (context.mounted) {
            !(cancel == "0")
                ? defaultErrorSnackBar(
                    context: context, message: 'Trip Canceled'.tr)
                : defaultSuccessSnackBar(
                    context: context, message: 'Trip Un Canceled'.tr);
          }
          getCalendarData();
        }
      });
    } catch (e) {
      calendarCancelByDateLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  RxBool isSendingTripRate = false.obs;

  Future<void> sendTripRate({
    required String comment,
    required String numOfStars,
    required String rea,
  }) async {
    isSendingTripRate.value = true;
    try {
      String userId = AppConstants.userRepository.userData.userId;
      Response response = await AppConstants.studentRepository.tripRate(
        userId: userId,
        comment: comment,
        rateStars: numOfStars,
      );
      if (response.statusCode == 200) {
        if (response.data['status'] == "success") {
          isSendingTripRate.value = false;
        } else {
          isSendingTripRate.value = false;
          throw (response.data['data']['error']);
        }
      } else {
        isSendingTripRate.value = false;
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isSendingTripRate.value = false;
      throw e.response!.data['data']['error'];
    }
  }

  RxBool isGettingCancelReasons = false.obs;
  CancelReasonsModel? cancelReasonsModel;
  CancelReasons? selectedReasons;
  Future<void> getCancelReasons() async {
    isGettingCancelReasons.value = true;
    update();
    try {
      Response response = await DioHelper.getData(
        url: 'cancel_reason/listing',
      );
      if (response.statusCode == 200) {
        cancelReasonsModel = CancelReasonsModel.fromJson(response.data);
        isGettingCancelReasons.value = false;
        update();
      } else {
        defaultErrorSnackBar(
          context: Get.context!,
          message: response.data['data']['error'],
        );
        isGettingCancelReasons.value = false;
        update();
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
      isGettingCancelReasons.value = false;
      update();
    }
  }
}
