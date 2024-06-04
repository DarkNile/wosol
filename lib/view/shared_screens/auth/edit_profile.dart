import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/shared_controllers/profile_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_phone_field.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/shared/widgets/shared_widgets/personal_pic.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
    super.key,
    required this.profileController,
  });

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomHeaderWithBackButton(
              header: "Edit Personal Information".tr,
              onBackPressed: () {
                Navigator.pop(context, true);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 14),
                      padding: AppConstants.edge(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24)),
                      color: AppColors.white,
                      child: Column(
                        children: [
                           PersonalPicture(profileController: profileController,),
                          const SizedBox(
                            height: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Username".tr,
                                style: AppFonts.style12Urb.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkBlue500Base),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextField(
                                hint: AppConstants.userType == 'Driver'
                                    ? "${AppConstants.userRepository.driverData.firstName} ${AppConstants.userRepository.driverData.lastName}"
                                    : AppConstants.userType == 'Student'?
                                "${AppConstants.userRepository.userData.userFname} ${AppConstants.userRepository.userData.userLname}"
                                : "${AppConstants.userRepository.employeeData.firstName} ${AppConstants.userRepository.employeeData.lastName}",
                                validate: true,
                                enabled: false,
                                fillColor: AppColors.dividerColor,
                                height: 42,
                                textEditingController: TextEditingController(),
                                onSubmit: (v) {},
                                label: '',
                                expands: false,
                                hintStyle: AppFonts.small.copyWith(
                                  color: AppColors.darkBlue400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.darkBlue200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phone Number".tr,
                                style: AppFonts.style12Urb.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkBlue500Base),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const CustomPhoneField(),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
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
                              CustomTextField(
                                validate: true,
                                enabled: false,
                                fillColor: AppColors.dividerColor,
                                textEditingController: TextEditingController(),
                                onSubmit: (v) {},
                                label: '',
                                height: 42,
                                expands: false,
                                hint: AppConstants.userType == 'Driver'
                                    ? AppConstants
                                        .userRepository.driverData.userEmail
                                    : AppConstants.userType == 'Student'
                                    ? AppConstants
                                        .userRepository.userData.userEmail
                                : AppConstants
                                    .userRepository.employeeData.userEmail,
                                hintStyle: AppFonts.small.copyWith(
                                  color: AppColors.darkBlue400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.darkBlue200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          DefaultButton(
                            function: () {
                              Get.back();
                            },
                            height: 44,
                            text: 'Save'.tr,
                            color: AppColors.logo,
                            borderRadius: 8,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
