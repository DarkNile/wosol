import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

import '../../../controllers/shared_controllers/auth_controllers/forget_password_controller.dart';
import '../../../shared/constants/constants.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController())..clearData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24 , top: 10),
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
                          "Enter your email here".tr,
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
                      "Email".tr,
                      style: AppFonts.style12Urb.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlue500Base),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GetBuilder<ForgetPasswordController>(
                      builder: (_) {
                        return EmailTextField(
                            controller: forgetPasswordController.emailController,
                            onSubmit: (String value) {},
                            onChange: (String value) {
                              forgetPasswordController.checkEmailValidation();
                            },
                            hint: 'Email'.tr,
                            label: '',
                            fieldValidation: forgetPasswordController.emailValidation);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Obx(() {
                  return DefaultButton(
                    loading: forgetPasswordController.isWaitingOtpLoading.value,
                    function: () {
                      forgetPasswordController.getOtpAPI(context);
                    },
                    text: "Send".tr,
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
