import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

import '../../../controllers/shared_controllers/auth_controllers/change_password_controller.dart';
import '../../../shared/constants/constants.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key,
  required this.fromProfile,
  this.id,
  this.userType,
  this.activationCode,});

  final bool fromProfile;
  final String? userType;
  final String? id;
  final String? activationCode;

  final ChangePasswordController changePasswordController = Get.put(ChangePasswordController())..clearData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap:
                          () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        AppConstants.localizationController
                            .currentLocale()
                            .languageCode ==
                            'en'
                            ? 'assets/icons/arrow-left.svg'
                            : 'assets/icons/arrow-right.svg',
                        width: 24,
                        height: 24,
                        fit: BoxFit.fill,
                        colorFilter: const ColorFilter.mode( AppColors.black,
                            BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SvgPicture.asset(
                      "assets/icons/logo.svg",
                      width: 97,
                      height: 65,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: Column(
                      children: [
                                                Text(
                          "change your password".tr,
                          style: AppFonts.medium.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkBlue500Base),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fromProfile? 'current password'.tr : "Password".tr,
                      style: AppFonts.style12Urb.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlue500Base),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GetBuilder<ChangePasswordController>(
                      builder: (_) {
                        return PasswordTextField(
                            controller: changePasswordController.passwordController,
                            fieldValidation: changePasswordController.passwordValidate,
                            validateText:
                            'Password should be more than 5 digits'.tr,
                            onSubmit: (val) {},
                            label: '',
                            hintText: fromProfile? 'current password'.tr : 'Password'.tr,
                            onChange: (val) {
                              changePasswordController.checkPasswordValidation();
                            });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fromProfile? 'new password'.tr : "confirm password".tr,
                      style: AppFonts.style12Urb.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlue500Base),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GetBuilder<ChangePasswordController>(
                      builder: (_) {
                        return PasswordTextField(
                            controller: changePasswordController.confirmPasswordController,
                            fieldValidation: changePasswordController.confirmPasswordValidate,
                            validateText:
                            fromProfile? 'Password should be more than 5 digits'.tr : 'Password doesn\'t match'.tr,
                            onSubmit: (val) {},
                            label: '',
                            hintText: fromProfile? 'new password'.tr : 'confirm password'.tr,
                            onChange: (val) {
                              changePasswordController.checkConfirmPasswordValidation(fromProfile);
                            });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                GetBuilder<ChangePasswordController>(
                    builder: (_)  {
                  return DefaultButton(
                    loading: changePasswordController.isChangePasswordLoading.value,
                    function: () {
                      changePasswordController.checkPasswordValidation();
                      changePasswordController.checkConfirmPasswordValidation(fromProfile);
                      if(fromProfile){
                        changePasswordController.changeProfilePasswordAPI(context);
                      }else {
                        changePasswordController.changeAuthPasswordAPI(context, userType!, activationCode!, id!);
                      }
                    },
                    text: "Confirm".tr,
                    borderRadius: 8,
                    color: AppColors.logo,
                    height: 48,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
