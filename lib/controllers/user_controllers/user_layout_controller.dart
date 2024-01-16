import 'package:get/get.dart';

class UserLayoutController extends GetxController {
  RxInt navBarIndex = 0.obs;

  void changeNavBarIndexValue(int index) {
    navBarIndex.value = index;
  }
}
