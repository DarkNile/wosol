import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/shared/widgets/shared_widgets/snakbar.dart';
import 'package:wosol/view/shared_screens/auth/employee_login_screen.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';

import '../../../shared/constants/constants.dart';

class ChangePasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextFieldValidation passwordValidate = TextFieldValidation.normal;
  TextFieldValidation confirmPasswordValidate = TextFieldValidation.normal;

  void clearData() {
    confirmPasswordController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordValidate = TextFieldValidation.normal;
    passwordValidate = TextFieldValidation.normal;
  }

  void checkPasswordValidation() {
    if (passwordController.text.length < 5) {
      passwordValidate = TextFieldValidation.notValid;
    } else {
      passwordValidate = TextFieldValidation.valid;
    }
    update();
  }

  void checkConfirmPasswordValidation(bool fromProfile) {
    if ((fromProfile
        ? (confirmPasswordController.text.length < 5)
        : (confirmPasswordController.text != passwordController.text))) {
      confirmPasswordValidate = TextFieldValidation.notValid;
    } else {
      confirmPasswordValidate = TextFieldValidation.valid;
    }
    update();
  }

  RxBool isChangePasswordLoading = false.obs;

  Future<void> changeAuthPasswordAPI(BuildContext context, String userType,
      String activationCode, String id) async {
    isChangePasswordLoading.value = true;
    try {
      if (passwordValidate == TextFieldValidation.valid &&
          confirmPasswordValidate == TextFieldValidation.valid) {
        await AppConstants.userRepository
            .changeAuthPassword(
          userType: userType,
          id: id,
          activationCode: activationCode,
          newPassword: passwordController.text,
        )
            .then((response) {
          isChangePasswordLoading.value = false;

          print('*********************');
          print(response.data);
          print('*********************');
          Get.offAll(() => userType == 'employee'? EmployeeLoginScreen() : LoginScreen());
        });
      }
    } catch (e) {
      isChangePasswordLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
    isChangePasswordLoading.value = false;
  }

  Future<void> changeProfilePasswordAPI(BuildContext context) async {
    isChangePasswordLoading.value = true;
    try {
      if (passwordValidate == TextFieldValidation.valid &&
          confirmPasswordValidate == TextFieldValidation.valid) {
        await AppConstants.userRepository
            .changeProfilePassword(
          currentPassword: passwordController.text,
          newPassword: confirmPasswordController.text,
        )
            .then((response) {
          isChangePasswordLoading.value = false;

          print('*********************');
          print(response.data);
          print('*********************');
          Get.back();
        });
      }
    } catch (e) {
      isChangePasswordLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
    isChangePasswordLoading.value = false;
    update();
  }
}
