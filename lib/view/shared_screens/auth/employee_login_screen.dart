import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/shared/widgets/shared_widgets/forgot_password.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';

import '../../../controllers/shared_controllers/auth_controllers/auth_controller.dart';

class EmployeeLoginScreen extends StatelessWidget {
  EmployeeLoginScreen({super.key});

  final AuthController loginController = Get.put(AuthController())..clearData();

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${"Welcome".tr} ",
                              style: AppFonts.header.copyWith(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Image.asset(
                              "assets/images/welcome.png",
                              width: 22,
                              height: 22,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Enter your account here".tr,
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
                      'Phone Number'.tr,
                      style: AppFonts.style12Urb.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlue500Base),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GetBuilder<AuthController>(
                      builder: (_) {
                        return CustomTextField(
                          textEditingController:
                              loginController.phoneController,
                          prefixIcon: Padding(
                            padding: AppConstants.edge(padding: const EdgeInsets.symmetric(horizontal: 8)),
                            child: Icon(
                              Icons.phone,
                              color: loginController.phoneController.text.isEmpty? AppColors.darkBlue400 : AppColors.logo,
                              size: 24,
                            ),
                          ),
                          fillColor: loginController.phoneController.text.isEmpty? AppColors.white
                              : AppColors.orange50,
                          onSubmit: (String value) {},
                          onChange: (String value) {
                            loginController.checkPhoneValidation();
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r'[\s\-\.\,]')),
                          ],
                          textInputType: const TextInputType.numberWithOptions(
                            decimal: false,
                            signed: false,
                          ),
                          validateText: "phoneIsntValid".tr,
                          hint: 'Phone Number'.tr,
                          label: '',
                          validate: !(loginController.phoneValidation ==
                              TextFieldValidation.notValid),
                          expands: false,
                        );
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
                      "Password".tr,
                      style: AppFonts.style12Urb.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlue500Base),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GetBuilder<AuthController>(
                      builder: (_) {
                        return PasswordTextField(
                            controller: loginController.passwordController,
                            fieldValidation: loginController.passwordValidate,
                            validateText:
                                'Password should be more than 5 digits'.tr,
                            onSubmit: (val) {},
                            label: '',
                            hintText: 'Password'.tr,
                            onChange: (val) {
                              loginController.checkPasswordValidation();
                            });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const ForgotPassword(fromEmployee: true,),
                const SizedBox(
                  height: 24,
                ),
                Obx(() {
                  return DefaultButton(
                    loading: loginController.isLoginLoading.value,
                    function: () {
                      loginController.signInAPI(context, isEmployee: true);
                    },
                    text: "Login".tr,
                    borderRadius: 8,
                    color: AppColors.logo,
                    height: 48,
                  );
                }),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      Get.offAll(() => LoginScreen());
                    },
                    child: Text(
                      "loginAsDriverOrUser".tr,
                      style: AppFonts.header.copyWith(color: AppColors.logo,),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
