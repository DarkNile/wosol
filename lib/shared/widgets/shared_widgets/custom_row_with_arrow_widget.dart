import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

import '../../constants/constants.dart';

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
              Icon(
                AppConstants.isEnLocale
                    ? CupertinoIcons.arrow_right
                    : CupertinoIcons.arrow_left,
                size: 18,
                color: AppColors.darkBlue500Base,
              ),
            ]),
          )
        : Row(
            children: [
              Flexible(
                child: Text(
                  from,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(
                  isHeader
                      ? 'assets/icons/arrow_right_header.svg'
                      : 'assets/icons/arrow-right.svg',
                  width: 16,
                  height: 16,
                ),
              ),
              Flexible(
                child: Text(
                  to,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(),
                ),
              ),
            ],
          );
  }
}
