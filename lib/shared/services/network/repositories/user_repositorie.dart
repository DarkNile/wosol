import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
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

  Future<Response> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'login',
        data: {
          'email': email,
          'password': password,
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

  Future<Response> forgetPassword({
    required String email,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: 'forget_password',
        data: {
          'email': email,
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
    required bool isDriver,
    required String id,
    required String activationCode,
    required String newPassword,
  }) async {
    try {
      Response response = await DioHelper.postData(
        url: isDriver? 'forget_password/driver_change_password' : 'forget_password/student_change_password',
        data: {
          if(isDriver)
            "driver_id": id,
          if(!isDriver)
            "student_id": id,
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
        url: AppConstants.isCaptain? 'driver/account/change_password' : 'student/account/change_password',
        data: {
          if(AppConstants.isCaptain)
            "driver_id": driverData.driverId,
          if(!AppConstants.isCaptain)
            "user_id": userData.userId,
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
          "user_id" : userData.userId,
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
