import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/view/shared_screens/auth/change_password.dart';
import 'package:wosol/view/shared_screens/auth/forget_password_otp_screen.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/widgets/shared_widgets/snakbar.dart';


class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  TextFieldValidation emailValidation = TextFieldValidation.normal;
  TextFieldValidation phoneValidation = TextFieldValidation.normal;

  void clearData() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    otpController = TextEditingController();
    emailValidation = TextFieldValidation.normal;
    phoneValidation = TextFieldValidation.normal;
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

  RxBool isWaitingOtpLoading = false.obs;

  String? otpCode;
  String? id;
  String? type;
  Future<void> getOtpAPI(BuildContext context, {required bool fromEmployee}) async {
    isWaitingOtpLoading.value = true;
    try {
      if (fromEmployee? (phoneValidation == TextFieldValidation.valid) : (emailValidation == TextFieldValidation.valid)) {
        await AppConstants.userRepository
            .forgetPassword(
          email: fromEmployee? phoneController.text : emailController.text,
          fromEmployee: fromEmployee
        )
            .then((response) {
          isWaitingOtpLoading.value = false;
          if(fromEmployee){
            otpCode = response.data['data']['activation_code'].toString();
            type = 'employee';
            id = response.data['data']['member_id'];
          } else{
            otpCode = response.data['data']['code'].toString();
            type = response.data['data']['type'];
            id = type == 'student'? response.data['data']['student_id'] : response.data['data']['driver_id'];
          }

          print('*********************');
          print(response.data);
          print('*********************');
          Get.to(() => OtpScreen());
        });
      }
    } catch (e) {
      isWaitingOtpLoading.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
    isWaitingOtpLoading.value = false;
    update();
  }

  void checkOtp(BuildContext context){
    print(otpCode);
    print(otpController.text);
    if(otpCode == otpController.text){
      Get.to(()=> ChangePasswordScreen(fromProfile: false, id: id!, userType: type, activationCode: otpCode!,));
    }else{
      defaultErrorSnackBar(
        context: context,
        message: 'Wrong code',
      );
    }
    update();
  }
}
