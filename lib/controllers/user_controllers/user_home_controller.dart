import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/trip_info_user_model.dart';

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

  // ? ===== Get Trip Info =====
  RxBool isGettingTripInfo = false.obs;
  RxList<TripInfoUserModel> tripInfo = <TripInfoUserModel>[].obs;
  Future<void> getTripInfo({required String tripId}) async {
    try {
      isGettingTripInfo.value = true;
      // var token = await CacheHelper.getData(key: 'token');
      Response response = await DioHelper.postData(
          url: 'trips/trip_user_id',
          // data: {'user_id': token, "trip_id": tripId},
          data: {"user_id": "247", "trip_id": "30"});
      if (response.statusCode == 200) {
        List data = response.data["data"];
        tripInfo.value =
            data.map((e) => TripInfoUserModel.fromJson(e)).toList().obs;
        isGettingTripInfo.value = false;
      } else {
        isGettingTripInfo.value = false;
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      isGettingTripInfo.value = false;
      throw e.response!.data['data']['error'];
    }
  }
}
