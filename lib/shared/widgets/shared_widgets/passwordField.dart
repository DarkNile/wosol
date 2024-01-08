import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

class PasswordField extends StatelessWidget {
   PasswordField({
    super.key,
  });
  
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppConstants.screenHeight(context) * .02),
        child: PasswordTextField(
            controller: textEditingController,
            fieldValidation: TextFieldValidation.valid,
            onIconPress: () {},
            suffixIcon: Icons.remove_red_eye_rounded,
            onSubmit: (val) {},
            onChange: (val) {}));
  }
}

