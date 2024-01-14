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
              height: 472,
              margin: EdgeInsets.symmetric(vertical: 16),
              padding: AppConstants.edge(
                  padding: EdgeInsets.symmetric(horizontal: 16)),
              color: Colors.white,
              child: Column(
                children: [
                  const PersonalPicture(),
                  CustomTextField(
                    validate: true,
                    textEditingController: TextEditingController(),
                    onSubmit: (v) {},
                    label: "Username".tr,
                    expands: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.darkBlue200,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomPhoneField(),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    validate: true,
                    textEditingController: TextEditingController(),
                    onSubmit: (v) {},
                    label: "Email".tr,
                    expands: false,
                    hint: "enter email".tr,
                    hintStyle: AppFonts.small.copyWith(
                      color: AppColors.darkBlue400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.darkBlue200,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    text: "Save".tr,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
