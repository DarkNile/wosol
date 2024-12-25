import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/widgets/shared_widgets/snakbar.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://wosol.net/system/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    )..interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Object? dataObject,
    required Map<String, dynamic> data,
  }) async {
    bool haveConnection = await AppConstants.isConnectedToInternet();
    if (haveConnection) {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': AppConstants.token,
      };

      Response response = await dio.post(
        url,
        queryParameters: query,
        data: dataObject ?? data,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(response.data['message']);
      }
    } else {
      throw 'No Internet connection.'.tr;
    }
  }

  static Future<Response> getData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    bool haveConnection = await AppConstants.isConnectedToInternet();
    if (haveConnection) {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': AppConstants.token,
      };

      return await dio.get(
        url,
        queryParameters: query,
      );
    } else {
      throw 'No Internet connection.'.tr;
    }
  }
}
