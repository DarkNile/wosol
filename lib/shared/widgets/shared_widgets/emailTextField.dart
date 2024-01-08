import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

class EmailField extends StatelessWidget {
   EmailField({
    super.key,
   
  });

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.screenHeight(context) * .02),
      child: EmailTextField(
          controller: textEditingController,
          onSubmit: (String value) {},
          fieldValidation: TextFieldValidation.valid),
    );
  }
}
