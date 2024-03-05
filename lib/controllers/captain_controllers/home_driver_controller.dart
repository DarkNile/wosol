import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';

import '../../shared/widgets/shared_widgets/snakbar.dart';

class HomeDriverController extends GetxController {
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
}
