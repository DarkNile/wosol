import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wosol/models/driver_model.dart';
import 'package:wosol/models/user_model.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

import '../../../constants/constants.dart';

class UserRepository extends GetxService {
  UserData userData = UserData(
    userId: '',
    userType: '',
    userFname: '',
    userLname: '',
    companyName: '',
    userEmail: '',
    userPass: '',
    telephone: '',
    supervisorId: '',
    userNationality: '',
    nationalId: '',
    gender: '',
    address: '',
    userZone: '',
    userCity: '',
    userDistrict: '',
    parentName: '',
    parentType: '',
    parntNationalId: '',
    parentPhone: '',
    parentEmail: '',
    dateAdded: '',
    lastLogin: '',
    userAgent: '',
    loginType: '',
    token: '',
    userImage: "",
  );

  DriverData driverData = DriverData(
    driverId: "",
    firstName: "",
    lastName: "",
    telephone: "",
    userEmail: "",
    userName: "",
    password: "",
    birthDate: "",
    idNo: "",
    idEndDate: "",
    licenseType: "",
    licenseEndDate: "",
    licenseCity: "",
    vehicles: "",
    active: "",
    lastLogin: "",
    userAgent: "",
    loginType: "",
    token: "",
    userImage: "",
    drivingLicence: '',
  );

  DriverData employeeData = DriverData(
    driverId: "",
    firstName: "",
    lastName: "",
    telephone: "",
    userEmail: "",
    userName: "",
    password: "",
    birthDate: "",
    idNo: "",
    idEndDate: "",
    licenseType: "",
    licenseEndDate: "",
    licenseCity: "",
    vehicles: "",
    active: "",
    lastLogin: "",
    userAgent: "",
    loginType: "",
    token: "",
    userImage: "",
    drivingLicence: '',
  );

  Future<Response> signIn({
    required String email,
    required String password,
    required bool isEmployee,
  }) async {
    try {
      // DeviceInfoService deviceInfoService = DeviceInfoService();
      // String? deviceId = await deviceInfoService.getDeviceId();
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String version = packageInfo.version;

      Response response = await DioHelper.postData(
        url: isEmployee ? 'employee/login' : 'login',
        data: {
          if (!isEmployee) 'email': email,
          if (isEmployee) 'mobile': email,
          'password': password,
          'device_id': AppConstants.fcmToken,
          'app_ver': version,
        },
      );
      print('%%%%%%%%%%%%%%%%%%%%%%%%%');
      print(isEmployee);
      print(response.statusCode);
      print('%%%%%%%%%%%%%%%%%%%%%%%%%');
      if (response.statusCode == 200) {
        return response;
      } else {
        throw (response.data['data']['error']);
      }
    } on DioException catch (e) {
      throw e.response!.data['data']['error'];
    }
  }

  Future<Response> forgetPassword(
      {required String email, required bool fromEmployee}) async {
    try {
      Response response = await DioHelper.postData(
        url: fromEmployee ? 'employee/forget_password' : 'forget_password',
        data: {
          if (!fromEmployee) 'email': email,
          if (fromEmployee) 'mobile': email,
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

  Future<Response> changeAuthPassword({
    required String userType,
    required String id,
    required String activationCode,
    required String newPassword,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: userType == 'driver'
            ? 'forget_password/driver_change_password'
            : userType == 'employee'
                ? 'employee/check_otp'
                : 'forget_password/student_change_password',
        data: {
          if (userType == 'driver') "driver_id": id,
          if (userType == 'employee') "member_id": id,
          if (userType == 'student') "student_id": id,
          "activation_code": activationCode,
          "new_password": newPassword,
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

  Future<Response> changeProfilePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: AppConstants.userType == 'Driver'
            ? 'driver/account/change_password'
            : AppConstants.userType == 'Employee'
                ? 'employee/password_change'
                : 'student/account/change_password',
        data: {
          if (AppConstants.userType == 'Driver')
            "driver_id": driverData.driverId,
          if (AppConstants.userType == 'Employee')
            "member_id": employeeData.driverId,
          if (AppConstants.userType == 'Student') "user_id": userData.userId,
          "current_password": currentPassword,
          "new_password": newPassword,
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

  Future<Response> subscription() async {
    try {
      Response response = await DioHelper.postData(
        url: "student/subscription",
        data: {
          "user_id": userData.userId,
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

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<String?> getDeviceId() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      print('Android Device ID: ${androidInfo.id}');
      return androidInfo.id; // Use 'id' instead of 'androidId'
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      print('iOS Device ID: ${iosInfo.identifierForVendor}');
      return iosInfo.identifierForVendor; // Unique ID on iOS
    }
    return null;
  }
}
