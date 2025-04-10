//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

import '../../constants/constants.dart';

class CustomProfileRowWidget extends StatelessWidget {
  const CustomProfileRowWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.isProfile = false,
    this.onTap,
    this.onTapEdit,
  });

  final String title;
  final String subTitle;
  final String image;
  final bool isProfile;
  final void Function()? onTap;

  final void Function()? onTapEdit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isProfile ? null : onTap,
      child: SizedBox(
        height: isProfile ? 67 : 64,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isProfile
                  ? SizedBox(
                      height: 42,
                      width: 42,
                      child: image.endsWith("user.png")
                          ? const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(image),
                            ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.5),
                      child: image.endsWith("svg")
                          ? SvgPicture.asset(
                              image,
                              height: 24,
                              width: 24,
                            )
                          : Image.asset(
                              image,
                              height: 24,
                              width: 24,
                            ),
                    ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.medium.copyWith(
                      color: AppColors.black800,
                      fontSize: isProfile ? 16 : 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    subTitle,
                    style: AppFonts.small.copyWith(
                      color: AppColors.darkBlue300,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              isProfile
                  ? DefaultButton(
                      borderRadius: 6,
                      function: onTapEdit,
                      text: "edit".tr,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      textColor: AppColors.btnEditColor,
                      color: AppColors.btnBgColor,
                      width: 60,
                      height: 32,
                    )
                  : Icon(
                      AppConstants.isEnLocale
                          ? CupertinoIcons.arrow_right
                          : CupertinoIcons.arrow_left,
                      size: 16,
                      color: AppColors.black800,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
