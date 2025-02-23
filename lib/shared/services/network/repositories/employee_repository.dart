import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/widgets/shared_widgets/snakbar.dart';

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
      if (response.data['status'] == 'success') {
        if(response.data['data']['not_trips']!= null){
          defaultSuccessSnackBar(context: Get.context!, message: AppConstants.isEnLocale? response.data['data']['not_trips']['msg_en'] : response.data['data']['not_trips']['msg_ar']);
        } else {
          return LatLng(double.tryParse(response.data['data']['to_lat']) ?? 0.0,
            double.tryParse(response.data['data']['to_long']) ?? 0.0);
        }
      } else {
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      throw e.response!.data['data']['error'];
    }
  }
}
