import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_phone_field.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/shared/widgets/shared_widgets/loginButton.dart';
import 'package:wosol/shared/widgets/shared_widgets/personal_pic.dart';

// Todo : check figma height of all TextFiled
class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomHeaderWithBackButton(header: "Edit Personal Information".tr),
            Container(
              // Todo : check figma height
              height: AppConstants.screenHeight(context) * .62,
              // Todo : margin check figma
              margin: const EdgeInsets.only(top: 16),
              padding: AppConstants.edge(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24)),
              color: AppColors.white,
              child: Column(
                children: [
                  const PersonalPicture(),
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
                        validate: true,
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
                        "Password".tr,
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
                        textEditingController: TextEditingController(),
                        onSubmit: (v) {},
                        label: '',
                        expands: false,
                        hint: "enter email".tr,
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
                  // Todo :  Sized Box height not like figma
                  const SizedBox(
                    height: 24,
                  ),
                  // Todo : use our custom button
                  // Todo : Missing borderRadius 8 not 10
                  CustomButton(
                    text: "Save".tr,
                    color: AppColors.logo,
                    height: 44,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
