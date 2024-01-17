import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class OptionalMessage extends StatelessWidget {
  const OptionalMessage({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Message(optional)".tr,
          style: AppFonts.medium.copyWith(color: AppColors.darkBlue500Base),
        ),
        Container(
          width: 343,
          height: 102,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColors.darkBlue200),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: TextField(
            // keyboardType: TextInputType.multiline,
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: 'enter your message'.tr,
              hintStyle: AppFonts.small,
              border: InputBorder.none,
            ),
            cursorColor: AppColors.darkBlue500Base,
            expands: true,
            maxLines: null,
          ),
        )
      ],
    );
  }
}
