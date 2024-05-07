import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://wosol.net/api/',
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
    );;
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Object? dataObject,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': token ??  await AppConstants.userTokens.getUserToken(),
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
  }

  static Future<Response> getData({
    required String url,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
