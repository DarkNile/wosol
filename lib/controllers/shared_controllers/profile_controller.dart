import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isNotification = false.obs;
  RxBool isFingerPrint = false.obs;

  void changeNotificationValue() {
    isNotification.value = !isNotification.value;
  }

  void changeFingerPrintValue() {
    isFingerPrint.value = !isFingerPrint.value;
  }
}
