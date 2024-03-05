import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/shared/services/local/cache_helper.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

class HomeDriverRepository extends GetxService {
  // ? ===== Get Trips =====
  Future<Response> getTrips() async {
    try {
      var token = await CacheHelper.getData(key: 'token');
      Response response = await DioHelper.postData(
        url: 'driver/trips/trip_student',
        data: {
          'user_id': token,
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      throw e.response!.data['data']['error'];
    }
  }

  // ? ===== Get Trip Info =====
  Future<Response> getTripInfo({required String tripId}) async {
    try {
      var token = await CacheHelper.getData(key: 'token');
      Response response = await DioHelper.postData(
        url: 'trips/trip_info',
        data: {'user_id': token, "trip_id": tripId},
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      throw e.response!.data['data']['error'];
    }
  }
}
