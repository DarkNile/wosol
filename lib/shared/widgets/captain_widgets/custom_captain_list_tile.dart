import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

// ignore: must_be_immutable
class CustomCaptainListTileWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  bool isCheckbox;
  bool isChat;
  bool noSubTitle;
  CustomCaptainListTileWidget(
      {super.key,
      this.isCheckbox = true,
      this.isChat = true,
      this.noSubTitle = false,
      required this.title,
      required this.subTitle});

  bool _checked = true;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isCheckbox)
            StatefulBuilder(
              builder: (context, setState) => Checkbox(
                  side: const BorderSide(color: AppColors.darkBlue300),
                  value: _checked,
                  onChanged: (val) {
                    setState(() {
                      _checked = val ?? false;
                    });
                  },
                  activeColor: AppColors.darkBlue300),
            ),
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: ShapeDecoration(
              color: AppColors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
            child: Text(
              'MA',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white900,
                fontSize: 14.0.sp(context),
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          noSubTitle
              ? Text(title,
                  style: AppFonts.medium.copyWith(
                    color: AppColors.darkBlue700,
                    fontWeight: FontWeight.w500,
                  ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: AppFonts.button
                            .copyWith(color: AppColors.black800)),
                    const SizedBox(height: 2),
                    Text(subTitle,
                        style: AppFonts.small
                            .copyWith(color: AppColors.darkBlue400)),
                  ],
                ),
          const Spacer(),
          isChat
              ? InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                      width: 42, height: 42, 'assets/icons/msg.svg'),
                )
              : InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                      width: 24, height: 24, 'assets/icons/list_mobile.svg'),
                )
        ]);
  }
}
