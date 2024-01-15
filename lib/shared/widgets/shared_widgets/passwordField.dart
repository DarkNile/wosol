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
    return PasswordTextField(
        controller: textEditingController,
        fieldValidation: TextFieldValidation.valid,
        onIconPress: () {},
        onSubmit: (val) {},
        label: '',
        onChange: (val) {});
  }
}
