import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

// Todo : What different between EmailField and EmailTextField !! 😃
class EmailField extends StatelessWidget {
  EmailField({
    super.key,
    required this.hint,
    required this.label,
  });
  final String hint;
  final String label;

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return EmailTextField(
        controller: textEditingController,
        onSubmit: (String value) {},
        hint: hint,
        label: label,
        validateText: "user.info@mail.com",
        fieldValidation: TextFieldValidation.valid);
  }
}
