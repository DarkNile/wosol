import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class RideCard extends StatelessWidget {
  const RideCard({
    super.key,
    required this.title,
    required this.time,
    required this.imgPath,
    this.isNextRide = false,
    required this.onTap,
  });
  final void Function() onTap;
  final String title;
  final String imgPath;
  final String time;
  final bool isNextRide;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: AppConstants.edge(
          padding: EdgeInsets.only(
            top: 18,
            left: 18,
            right: isNextRide ? 15 : 18,
            bottom: 18,
          ),
        ),
        decoration: BoxDecoration(
          color: isNextRide ? AppColors.logo : AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: AppConstants.screenWidth(context),
        // height: 123,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"from".tr} $title\n${isNextRide ? "${"within".tr} $time" : "${"at".tr} $time"}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: AppFonts.header.copyWith(
                      fontSize: isNextRide ? 18 : 14,
                      color: isNextRide ? AppColors.white : AppColors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        'rideDetails'.tr,
                        style: AppFonts.small.copyWith(
                          fontSize: 14,
                          color: isNextRide
                              ? AppColors.white
                              : AppColors.darkBlue500Base,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        AppConstants.isEnLocale
                            ? CupertinoIcons.arrow_right
                            : CupertinoIcons.arrow_left,
                        size: 18,
                        color: isNextRide
                            ? AppColors.white
                            : AppColors.darkBlue500Base,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SvgPicture.asset(imgPath),
          ],
        ),
      ),
    );
  }
}
