import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../dio_helper.dart';

class EmployeeRepository extends GetxService {
  // ? ===== Get Trips =====
  Future<Response> getTrips(String employeeId) async {
    print("fggg $employeeId");
    try {
      Response response = await DioHelper.postData(
        url: 'employee/trips',
        data: {
          "member_id": employeeId,
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

  Future<Response> getGroupsList(String employeeId) async {
    try {
      Response response = await DioHelper.postData(
        url: 'employee/get_groups',
        data: {
          "member_id": employeeId,
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

  Future<LatLng?> requestRide({
    required String employeeId,
    required String groupId,
    required String lat,
    required String lng,
    required String date,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: 'employee/request_ride',
        data: {
          "member_id": employeeId,
          "group_id": groupId,
          "lat": lat,
          "lng": lng,
          'trip_date': date,
        },
      );
      if (response.statusCode == 200) {
        return LatLng(double.tryParse(response.data['data']['to_lat']) ?? 0.0,
            double.tryParse(response.data['data']['to_long']) ?? 0.0);
      } else {
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      throw e.response!.data['data']['error'];
    }
  }
}
