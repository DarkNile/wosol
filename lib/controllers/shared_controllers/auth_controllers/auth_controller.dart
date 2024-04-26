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
  TextEditingController passwordController = TextEditingController();

  TextFieldValidation emailValidation = TextFieldValidation.normal;
  TextFieldValidation passwordValidate = TextFieldValidation.normal;

  void clearData() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailValidation = TextFieldValidation.normal;
    passwordValidate = TextFieldValidation.normal;
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

  Future<void> signInAPI(BuildContext context) async {
    isLoginLoading.value = true;
    try {
      if (emailValidation == TextFieldValidation.valid &&
          passwordValidate == TextFieldValidation.valid) {
        await AppConstants.userRepository
            .signIn(
          email: emailController.text,
          password: passwordController.text,
        )
            .then((response) {
          isLoginLoading.value = false;
          if (response.data['data']['login_type'] == 'Student') {
            UserModel value = UserModel.fromJson(response.data);
            AppConstants.userRepository.userData = value.data;
            CacheHelper.setData(
                key: 'UserData', value: jsonEncode(value.data.toJson()));
            CacheHelper.setData(key: 'token', value: value.data.token);
            CacheHelper.setData(
              key: 'userType',
              value: false,
            );
            AppConstants.isCaptain = false;
          } else {
            DriverModel value = DriverModel.fromJson(response.data);
            AppConstants.userRepository.driverData = value.data;
            CacheHelper.setData(
                key: 'DriverData', value: jsonEncode(value.data.toJson()));
            CacheHelper.setData(key: 'token', value: value.data.token);
            CacheHelper.setData(
              key: 'userType',
              value: true,
            );
            AppConstants.isCaptain = true;
          }
          Get.to(() => AppConstants.isCaptain
              ? const DriverLayoutScreen()
              : const UserLayoutScreen());
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
