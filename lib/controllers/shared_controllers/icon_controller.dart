import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class IconController extends GetxController {
  RxBool isIconOn = false.obs;

  void toggleIcon() {
    isIconOn.toggle();
  }
}