import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/models/driver_model.dart';
import 'package:wosol/models/user_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/services/local/cache_helper.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/shared/widgets/shared_widgets/snakbar.dart';

import '../../../view/captain_screens/driver_layout_screen.dart';
import '../../../view/user_screens/user_layout_screen.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextFieldValidation emailValidation = TextFieldValidation.normal;
  TextFieldValidation phoneValidation = TextFieldValidation.normal;
  TextFieldValidation passwordValidate = TextFieldValidation.normal;

  void clearData() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    emailValidation = TextFieldValidation.normal;
    phoneValidation = TextFieldValidation.normal;
    passwordValidate = TextFieldValidation.normal;
  }

  void checkPhoneValidation() {
    if (phoneController.text.isEmpty) {
      phoneValidation = TextFieldValidation.notValid;
    } else {
      if (isValidSaudiPhoneNumber("+966${phoneController.text}")) {
        phoneValidation = TextFieldValidation.valid;
      } else {
        phoneValidation = TextFieldValidation.notValid;
      }
    }
    update();
  }

  bool isValidSaudiPhoneNumber(String phoneNumber) {
    RegExp saudiRegex = RegExp(r'^(\+966|00966|0)(5[0-9]{8})$');
    return saudiRegex.hasMatch(phoneNumber);
  }

  void checkEmailValidation() {
    if (emailController.text.isNotEmpty) {
      emailController.text = emailController.text.toLowerCase();
      emailController.text = emailController.text.removeAllWhitespace;
      emailController.selection = TextSelection.fromPosition(
          TextPosition(offset: emailController.text.length));

      if (emailController.text.isEmail) {
        emailValidation = TextFieldValidation.valid;
      } else {
        emailValidation = TextFieldValidation.notValid;
      }
    } else {
      emailValidation = TextFieldValidation.notValid;
    }
    update();
  }

  void checkPasswordValidation() {
    if (passwordController.text.length < 5) {
      passwordValidate = TextFieldValidation.notValid;
    } else {
      passwordValidate = TextFieldValidation.valid;
    }
    update();
  }

  RxBool isLoginLoading = false.obs;

  Future<void> signInAPI(BuildContext context,
      {required bool isEmployee}) async {
    isLoginLoading.value = true;
    try {
      if ((isEmployee
              ? (phoneValidation == TextFieldValidation.valid)
              : (emailValidation == TextFieldValidation.valid)) &&
          passwordValidate == TextFieldValidation.valid) {
        await AppConstants.userRepository
            .signIn(
                email: isEmployee ? phoneController.text : emailController.text,
                password: passwordController.text,
                isEmployee: isEmployee)
            .then((response) {
          isLoginLoading.value = false;
          if (response.data['data']['login_type'] == 'Student') {
            UserModel value = UserModel.fromJson(response.data);
            AppConstants.userRepository.userData = value.data;
            AppConstants.token = value.data.token;
            CacheHelper.setData(
                key: 'UserData', value: jsonEncode(value.data.toJson()));
            CacheHelper.setData(key: 'token', value: value.data.token);
            CacheHelper.setData(
              key: 'userType',
              value: 'Student',
            );
            AppConstants.userType = 'Student';
          } else if (response.data['data']['login_type'] == 'Driver') {
            DriverModel value = DriverModel.fromJson(response.data);
            AppConstants.userRepository.driverData = value.data;
            AppConstants.token = value.data.token;
            CacheHelper.setData(
                key: 'DriverData', value: jsonEncode(value.data.toJson()));
            CacheHelper.setData(key: 'token', value: value.data.token);
            CacheHelper.setData(
              key: 'userType',
              value: 'Driver',
            );
            AppConstants.userType = 'Driver';
          } else if (response.data['data']['login_type'] == 'Employee') {
            DriverModel value = DriverModel.fromJson(response.data);
            AppConstants.userRepository.employeeData = value.data;
            AppConstants.token = value.data.token;
            CacheHelper.setData(
                key: 'EmployeeData', value: jsonEncode(value.data.toJson()));
            CacheHelper.setData(key: 'token', value: value.data.token);
            CacheHelper.setData(
              key: 'userType',
              value: 'Employee',
            );
            AppConstants.userType = 'Employee';
          }
          Get.offAll(() => AppConstants.userType == 'Student'
              ? const UserLayoutScreen()
              : const DriverLayoutScreen());
        });
      }
    } catch (e) {
      isLoginLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
    isLoginLoading.value = false;
  }
}
