import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

class custom_phoneNum_field extends StatelessWidget {
  const custom_phoneNum_field({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      expands: false,
            contentPadding: AppConstants.edge(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
            width: 343,
            height: 42,
            validate: true,
            hint: "",
            prefixIcon: Padding(
    padding:
        AppConstants.edge(padding: const EdgeInsets.only(left: 14, right: 5)),
    child: Text(
      "+965",
      style: AppFonts.small.copyWith(color: AppColors.logo),
    ),
            ),
            textInputType: TextInputType.number,
            textEditingController: TextEditingController(),
            onSubmit: (v) {},
            label: "Phone Number",
          );
  }
}
