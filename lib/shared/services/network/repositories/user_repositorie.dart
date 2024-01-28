import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:wosol/models/driver_model.dart';
import 'package:wosol/models/user_model.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

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

}
