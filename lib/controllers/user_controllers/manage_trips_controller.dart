import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../models/manage_trips_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';

class UserManageTripsController extends GetxController {

  void changeToggleValue(ManageTripsModel manageTrips) {
    manageTrips.isToggleOn.value = !manageTrips.isToggleOn.value;
  }

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
        if (context.mounted) {
          defaultSuccessSnackBar(
            context: context,
            message: 'Trip canceled',
          );
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
        endPoint: cancelReason == null? '/student/calendar/calendar_un_cancel_by_date' : '/student/calendar/calendar_cancel_by_date',
        date: date,
        userId: userId,
        cancel: cancel,
        cancelReason: cancelReason,
      )
          .then((response) {
        calendarCancelByDateLoading.value = false;
        if (context.mounted) {
          defaultSuccessSnackBar(
            context: context,
            message: 'Trip canceled',
          );
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
}
