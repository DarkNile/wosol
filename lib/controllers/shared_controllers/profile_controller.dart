import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

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

  void changeImage(){
    update(["imageUpdated"]);
  }

  String driverTerms = '';
  String userTerms = '';

  Future<void> userTermsApi() async {
    try {
      Response response = await DioHelper.postData(
        url: 'student/terms',
        data: {},
      );
      if (response.statusCode == 200) {
        userTerms = response.data['data']['text'];
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

  Future<void> driverTermsApi() async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/terms',
        data: {},
      );
      if (response.statusCode == 200) {
        driverTerms = response.data['data']['text'];
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
}
