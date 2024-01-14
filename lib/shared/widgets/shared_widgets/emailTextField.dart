import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

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
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 12, left: 12),
      child: EmailTextField(
          controller: textEditingController,
          onSubmit: (String value) {},
          hint: hint,
          label: label,
          validateText: "user.info@mail.com",
          fieldValidation: TextFieldValidation.valid),
    );
  }
}
