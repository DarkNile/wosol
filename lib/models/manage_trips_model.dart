import 'package:get/get.dart';

class ManageTripsModel {
  String from;
  String to;
  String time;
  RxBool isToggleOn;

  ManageTripsModel({
    required this.from,
    required this.to,
    required this.time,
    required this.isToggleOn,
  });
}
