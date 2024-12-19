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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: PersonalPicture(
                            profileController: profileController,
                          )),
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
                              Text(
                                AppConstants.userType == 'Driver'
                                    ? "${AppConstants.userRepository.driverData.firstName} ${AppConstants.userRepository.driverData.lastName}"
                                    : AppConstants.userType == 'Student'
                                        ? "${AppConstants.userRepository.userData.userFname} ${AppConstants.userRepository.userData.userLname}"
                                        : "${AppConstants.userRepository.employeeData.firstName} ${AppConstants.userRepository.employeeData.lastName}",
                                style: AppFonts.style12Urb.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.black),
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
                              Text(
                                "+965 ${AppConstants.userType == 'Driver' ? AppConstants.userRepository.driverData.telephone : AppConstants.userType == 'Employee' ? AppConstants.userRepository.employeeData.telephone : AppConstants.userRepository.userData.telephone}",
                                style: AppFonts.style12Urb.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.black),
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
                                "Email".tr,
                                style: AppFonts.style12Urb.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkBlue500Base),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                AppConstants.userType == 'Driver'
                                    ? AppConstants
                                        .userRepository.driverData.userEmail
                                    : AppConstants.userType == 'Student'
                                        ? AppConstants
                                            .userRepository.userData.userEmail
                                        : AppConstants.userRepository
                                            .employeeData.userEmail,
                                style: AppFonts.style12Urb.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.black),
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
