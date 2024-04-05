import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/shared/services/local/cache_helper.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

class HomeDriverRepository extends GetxService {
  // ? ===== Get Trips =====
  Future<Response> getTrips(String driverId) async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/trips',
        data: {
          "driver_id": driverId,
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

  // ? ===== Trip States =====
  Future<Response> tripStates({
    required String tripId,
    String? tripUserId,
    String? attendance,
    required int state,
  }) async {
    List<String> endPoints = [
      'trip_start',
      'trip_cancel',
      'trip_end',
      'trip_attendace'
    ];
    try {
      Response response = await DioHelper.postData(
        url: '/driver/trips/${endPoints[state]}',
        data: {
          "trip_id": tripId,
          if (tripUserId != null) "trip_user_id": tripUserId,
          if (attendance != null) "attendance": attendance,
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

  // ? ===== Get Requests by notifications =====
  Future<Response> getNotificationRequests({
    required String driverId,
  }) async {
    print("driver_id: $driverId");
    try {
      Response response = await DioHelper.postData(
        url: 'driver/notifications/view_reuqest_ride',
        data: {"driver_id": driverId},
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

  Future<Response> approveNotificationRequests({
    required String requestId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/notifications/reuqest_ride_approved',
        data: {"driver_id": requestId},
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

  Future<Response> sendTripAttendance({
    required String tripId,
    required String userId,
    required bool isAttended,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/trips/trip_attendace',
        data: {
          "trip_id": tripId,
          "trip_user_id": userId,
          "attendance": isAttended ? "1" : "2",
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

  Future<Response> driverVehicle({
    required String driverId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'driver/trips/driver_vehicle',
        data: {
          "driver_id": driverId,
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
}
