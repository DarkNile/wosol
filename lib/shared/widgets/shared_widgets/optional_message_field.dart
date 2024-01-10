import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

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
            top: 20,
            left: 12,
            right: 12,
            bottom: 70,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFD1D7E6)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text(
                    'enter your message',
                    style: TextStyle(
                      color: Color(0xFFA1AECB),
                      fontSize: 14,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
