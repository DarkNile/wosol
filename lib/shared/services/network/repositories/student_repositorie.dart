import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';

import '../dio_helper.dart';

class StudentRepository extends GetxService {
  Future<Response> calendarCancel({
    required String calendarId,
    required String userId,
    required String cancel,
    String? cancelReason,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: cancelReason == null
            ? 'student/calendar/calendar_un_cancel'
            : 'student/calendar/calendar_cancel',
        data: {
          "calendar_id": calendarId,
          "user_id": userId,
          "cancel": cancel,
          if (cancelReason != null) "cancel_reason": cancelReason
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

  Future<Response> cancelByDate({
    required String endPoint,
    required String date,
    required String userId,
    required String cancel,
    String? cancelReason,
    String? cancelReasonId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: endPoint,
        data: {
          "user_id": userId,
          "date": date,
          "cancel": cancel,
          if (cancelReasonId != null) "reason_id": cancelReasonId,
          if (cancelReason != null) "cancel_reason": cancelReason
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

  Future<Response> tripCancel({
    required String tripUserId,
    required String userId,
    required String tripId,
    required String cancel,
    String? cancelReason,
    String? cancelReasonId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: cancelReason == null
            ? '/student/trips/un_cancel_trip_user'
            : '/student/trips/cancel_trip_user',
        data: {
          "trip_user_id": tripUserId,
          "user_id": userId,
          "trip_id": tripId,
          "cancel": cancel,
          if (cancelReasonId != null) "reason_id": cancelReasonId,
          if (cancelReason != null) "cancel_reason": cancelReason
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

  Future<Response> tripRate({
    required String rateStars,
    required String userId,
    required String comment,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: "student/rate",
        data: {
          "trip_user_id": userId,
          "rate_stars": rateStars,
          "rate_comment": comment,
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


  Future<Map<String , dynamic>> getStudentNotification({
    required String userId,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'student/notifications/view',
        data: {"user_id": userId},
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      throw e.response!.data['data']['error'];
    }
  }
}
