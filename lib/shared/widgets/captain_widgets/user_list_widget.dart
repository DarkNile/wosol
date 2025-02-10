import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/captain_widgets/custom_captain_list_tile.dart';

class UserListWidget extends StatelessWidget {
  final bool hasSubTitle;
  final int length;
  const UserListWidget({super.key, this.hasSubTitle = true, this.length = 6});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x1E000000),
              blurRadius: 2,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CustomUserHeader(
                title: '${"confirmed".tr} (11 ${"users".tr})',
                subTitle: '${"from".tr} 14 ${"users".tr}',
                hasSubTitle: hasSubTitle),
            const SizedBox(
              height: 6,
            ),
            ...List.generate(
                length,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomCaptainListTileWidget(
                        title: 'Mostafa Abdelrahman',
                        subTitle: '',
                        isChat: false,
                        // contact: (){},
                        isUserList: true,
                        isCheckbox: false,
                        noSubTitle: true,
                      ),
                    ))
          ],
        ));
  }
}

class _CustomUserHeader extends StatelessWidget {
  final bool hasSubTitle;
  final String title;
  final String subTitle;
  const _CustomUserHeader(
      {this.hasSubTitle = true, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return hasSubTitle
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: AppFonts.medium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.black800,
                  )),
              Text(subTitle,
                  textAlign: TextAlign.right,
                  style: AppFonts.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkBlue400,
                  ))
            ],
          )
        : Text(title,
            style: AppFonts.medium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.black800,
            ));
  }
}
