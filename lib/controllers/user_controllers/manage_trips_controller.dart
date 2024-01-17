import 'package:get/get.dart';
import 'package:wosol/models/manage_trips_model.dart';

class UserManageTripsController extends GetxController {

  void changeToggleValue(ManageTripsModel manageTrips) {
    manageTrips.isToggleOn.value = !manageTrips.isToggleOn.value;
  }
}
