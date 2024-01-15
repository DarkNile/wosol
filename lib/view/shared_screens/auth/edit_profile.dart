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
              margin: const EdgeInsets.symmetric(vertical: 16),
              // Todo : missing padding should be 24 vertical check figma
              padding: AppConstants.edge(
                  padding: const EdgeInsets.symmetric(
                horizontal: 16,
              )),
              color: Colors.white,
              child: Column(
                children: [
                  const PersonalPicture(),
                  // Todo : Sized Box Missing
                  // Todo : label not like figma please check figma ☺️
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
                  // Todo : label not like figma please check figma ☺️
                  const CustomPhoneField(),

                  // Todo :  Sized Box height not like figma
                  const SizedBox(
                    height: 24,
                  ),
                  // Todo : label not like figma please check figma ☺️
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
                  // Todo :  Sized Box height not like figma
                  const SizedBox(
                    height: 16,
                  ),
                  // Todo : use our custom button
                  // Todo : user height from figma and style of button
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
