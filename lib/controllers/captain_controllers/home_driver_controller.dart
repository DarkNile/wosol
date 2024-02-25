import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';

class HomeDriverController extends GetxController {
  Future<void> getTrips() async {
    AppConstants.homeDriverRepository.getTrips();
  }
}
