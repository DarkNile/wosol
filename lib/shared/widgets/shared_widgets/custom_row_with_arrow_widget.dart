import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class CustomRowWithArrowWidget extends StatelessWidget {
  final String from;
  final String to;
  final bool isHeader;
  final bool isButton;
  final void Function()? onTapButton;
  const CustomRowWithArrowWidget(
      {super.key,
      required this.from,
      required this.to,
      this.isHeader = true,
      this.isButton = false,
      this.onTapButton});

  TextStyle textStyle() {
    return isHeader
        ? AppFonts.medium.copyWith(
            color: AppColors.black800,
          )
        : AppFonts.medium.copyWith(
            color: AppColors.darkBlue500Base,
            fontSize: 13,
          );
  }

  @override
  Widget build(BuildContext context) {
    return isButton
        ? InkWell(
            onTap: onTapButton,
            child: Row(children: [
              Text(from,
                  style: AppFonts.small.copyWith(
                    color: AppColors.darkBlue500Base,
                  )),
              const SizedBox(width: 10),
              SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                width: 18,
                height: 18,
              ),
            ]),
          )
        : Row(
            children: [
              Text(from, style: textStyle()),
              const SizedBox(width: 10),
              SvgPicture.asset(
                isHeader
                    ? 'assets/icons/arrow_right_header.svg'
                    : 'assets/icons/arrow-right.svg',
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 10),
              Text(to, style: textStyle())
            ],
          );
  }
}
