import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/change_days_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';

class UserChangeDaysController extends GetxController {
  // ? ===== Get Change Days API =====
  RxBool getChangeDaysLoading = false.obs;
  RxList<ChangeDaysModel> changeDaysList = RxList<ChangeDaysModel>([]);
  Future<void> getChangeDays({required BuildContext context}) async {
    changeDaysUpdateDone.value = false;
    getChangeDaysLoading.value = true;
    try {
      Response response = await DioHelper.postData(
        url: "student/request_change_days",
        data: {
          //"280"
          "user_id": AppConstants.userRepository.userData.userId,
        },
      );
      log("getChangeDays() ==>> response: ${response.data}");
      if (response.statusCode == 200) {
        List data = response.data['data'];
        changeDaysList.clear();
        for (var day in data) {
          changeDaysList.add(ChangeDaysModel.fromJson(day));
        }
        getChangeDaysLoading.value = false;
      }
    } on DioException catch (e) {
      getChangeDaysLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.message.toString(),
        );
      }
    }
  }

  // ? ===== Get Change Days Update API =====
  RxInt selectedDayCancelIndex = RxInt(-90);
  RxInt selectedDayUpdateIndex = RxInt(-90);
  RxBool changeDaysUpdateLoading = false.obs;
  RxBool changeDaysUpdateDone = false.obs;

  Future<void> changeDaysUpdate(
      {required BuildContext context,
      required ChangeDaysModel changeDaysModel}) async {
    changeDaysUpdateLoading.value = true;
    try {
      Response response = await DioHelper.postData(
          url: "student/request_change_days/update",
          data: changeDaysModel.toJson());
      log("changeDaysUpdate() ==>> response: ${response.data}");
      if (response.statusCode == 200) {
        if (context.mounted) {
          defaultSuccessSnackBar(context: context, message: "Success".tr);
        }
        changeDaysUpdateDone.value = true;
        changeDaysUpdateLoading.value = false;
      } else {
        changeDaysUpdateLoading.value = false;
        changeDaysUpdateDone.value = false;
      }
    } on DioException catch (e) {
      changeDaysUpdateLoading.value = false;
      changeDaysUpdateDone.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.message.toString(),
        );
      }
    }
  }
}
