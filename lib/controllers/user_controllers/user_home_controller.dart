import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../models/calendar_model.dart';
import '../../shared/services/network/dio_helper.dart';

class UserHomeController extends GetxController {
  List<CalendarData> calendarData = [];
  RxBool isGettingCalendar = false.obs;

  Future<void> getCalendarData() async {
    isGettingCalendar.value = true;
    try {
      Response response = await DioHelper.postData(
        url: 'calendar',
        data: {"user_id": "185"},
      );
      if (response.statusCode == 200) {
        isGettingCalendar.value = false;
        calendarData = CalendarModel.fromJson(response.data).data;
      } else {
        isGettingCalendar.value = false;
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingCalendar.value = false;
      throw e.response!.data['data']['error'];
    }
  }
}
