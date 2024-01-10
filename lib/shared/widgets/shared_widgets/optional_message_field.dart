import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

class OptionalMessage extends StatelessWidget {
  const OptionalMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Message(optional)",
          style: AppFonts.medium.copyWith(color: AppColors.darkGreyHint),
        ),
        Container(
          width: 343,
          height: 102,
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFD1D7E6)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Expanded(
            child: TextField(
              // keyboardType: TextInputType.multiline,
              controller: TextEditingController(),
              decoration: InputDecoration(
                hintText: 'enter your message',
                hintStyle: AppFonts.small,
                border: InputBorder.none,
              ),
              cursorColor: AppColors.darkGreyHint,
              expands: true,
              maxLines: null,
            ),
          ),
        )
      ],
    );
  }
}
