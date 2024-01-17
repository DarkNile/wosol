import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      expands: false,
      contentPadding: AppConstants.edge(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
      validate: true,
      hint: "",
      enabled: false,
      prefixIcon: Padding(
        padding: AppConstants.edge(
            padding:
                const EdgeInsets.only(left: 14, right: 5, top: 10, bottom: 8)),
        child: Text(
          "+965",
          style: AppFonts.small.copyWith(color: AppColors.logo, fontSize: 14),
        ),
      ),
      textInputType: TextInputType.number,
      textEditingController: TextEditingController(),
      onSubmit: (v) {},
      label: '',
      height: 42,
      fillColor: AppColors.dividerColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.darkBlue200,
        ),
      ),
    );
  }
}
