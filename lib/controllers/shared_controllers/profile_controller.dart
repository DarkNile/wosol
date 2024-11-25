import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:launcher_name/constants.dart';
import 'package:wosol/models/subscription_model.dart';

import '../../shared/constants/constants.dart';
import '../../shared/services/network/dio_helper.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';

class ProfileController extends GetxController {
  RxBool isNotification = false.obs;
  RxBool isFingerPrint = false.obs;

  void changeNotificationValue() {
    isNotification.value = !isNotification.value;
  }

  void changeFingerPrintValue() {
    isFingerPrint.value = !isFingerPrint.value;
  }

  void changeImage() {
    update(["imageUpdated"]);
  }

  String terms = '';

  Future<void> termsApi() async {
    try {
      Response response = await DioHelper.postData(
        url: AppConstants.userType == 'Driver'
            ? 'driver/terms'
            : AppConstants.userType == 'Employee'
                ? 'employee/terms'
                : 'student/terms',
        data: {},
      );
      if (response.statusCode == 200) {
        terms = response.data['data']['text'];
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

  RxBool isSubscriptionLoading = false.obs;
  SubscriptionModel? currentSubscription;
  List<SubscriptionModel> previousSubscriptions = [];

  Future<void> subscriptionApi() async {
    currentSubscription = null;
    previousSubscriptions = [];
    isSubscriptionLoading.value = true;
    update(['imageUpdated']);

    log("currentSubscription $currentSubscription");
    try {
      Response response = await AppConstants.userRepository.subscription();

      if (response.statusCode == 200) {
        bool setCurrent = true;
        response.data['data'].forEach((sub) {

          if (setCurrent) {
            currentSubscription = SubscriptionModel.fromJson(sub);
            setCurrent = false;
          } else {
            previousSubscriptions.add(SubscriptionModel.fromJson(sub));
          }
        });
        isSubscriptionLoading.value = false;
        update(['imageUpdated']);
      } else {
        isSubscriptionLoading.value = false;
        update(['imageUpdated']);
        defaultErrorSnackBar(
          context: Get.context!,
          message: response.data['data']['error'],
        );
      }
    } on DioException catch (e) {
      isSubscriptionLoading.value = false;
      update(['imageUpdated']);
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['error'],
      );
    }
  }
}
