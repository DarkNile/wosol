import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../models/calendar_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';

class UserHomeController extends GetxController {
  List<CalendarData> calendarData = [];
  RxBool isGettingCalendar = false.obs;

  Future<void> getCalendarData() async {
    isGettingCalendar.value = true;
    try {
      Response response = await DioHelper.postData(
        url: 'calendar',
        data: {"user_id": "185"},
      );
      if (response.statusCode == 200) {
        isGettingCalendar.value = false;
        calendarData = CalendarModel.fromJson(response.data).data;
      } else {
        isGettingCalendar.value = false;
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingCalendar.value = false;
      throw e.response!.data['data']['error'];
    }
  }

  RxBool tripCancelLoading = false.obs;
  Future<void> tripCancelAPI({
    required BuildContext context,
    required String tripUserId,
    required String userId,
    required String tripId,
    required String cancel,
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
        cancelReason: cancelReason,
      )
          .then((response) {
        tripCancelLoading.value = false;
        if (context.mounted) {
          defaultSuccessSnackBar(
            context: context,
            message: 'Trip canceled',
          );
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
        endPoint: cancelReason == null? '/un_cancel_trip_user_by_date' : '/cancel_trip_user_by_date',
        date: date,
        userId: userId,
        cancel: cancel,
        cancelReason: cancelReason,
      )
          .then((response) {
        tripCancelByDateLoading.value = false;
        if (context.mounted) {
          defaultSuccessSnackBar(
            context: context,
            message: 'Trip canceled',
          );
        }
      });
    } catch (e) {
      tripCancelByDateLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }
}
