import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_phone_field.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/shared/widgets/shared_widgets/loginButton.dart';
import 'package:wosol/shared/widgets/shared_widgets/personal_pic.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHeaderWithBackButton(
              header: "Edite Personal Information"),
          Container(
            margin:
                EdgeInsets.only(top: AppConstants.screenHeight(context) * .02),
            color: Colors.white,
            width: 375,
            height: 472,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PersonalPicture(),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 12, left: 12),
                  child: CustomTextField(
                    validate: true,
                    textEditingController: TextEditingController(),
                    onSubmit: (v) {},
                    label: "Username",
                    expands: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.darkBlue200,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 12, left: 12),
                  child: CustomPhoneField(),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 12, left: 12),
                  child: CustomTextField(
                    validate: true,
                    textEditingController: TextEditingController(),
                    onSubmit: (v) {},
                    label: "Email",
                    expands: false,
                    hint: "enter email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.darkBlue200,
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  text: "Save",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
