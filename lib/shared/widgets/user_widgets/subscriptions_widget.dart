import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

// ignore: must_be_immutable
class SubscriptionsWidget extends StatelessWidget {
  // Put Model Here
  SubscriptionsWidget({super.key});

  double height = 62;
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_, setState) => Container(
        height: isExpanded ? 336 : 64,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.darkBlue100),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ID #58869',
                          style: AppFonts.button.copyWith(
                            color: AppColors.logo,
                          )),
                      SvgPicture.asset(
                        isExpanded
                            ? 'assets/icons/arrow-up.svg'
                            : 'assets/icons/arrow-down.svg',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Column(
                  children: [
                    Container(
                      height: 1,
                      color: AppColors.darkBlue100,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _CustomRowWidget(
                      name: 'price'.tr,
                      value: '134.50 ${"SAR".tr}',
                    ),
                    _CustomRowWidget(
                      isBackGroundWhite: false,
                      name: 'startDate'.tr,
                      value: '13 Sep, 2023',
                    ),
                     _CustomRowWidget(
                      name: 'endDate'.tr,
                      value: '25 Jun, 2024',
                    ),
                     _CustomRowWidget(
                      isBackGroundWhite: false,
                      name: 'tripType'.tr,
                      value: 'roundTrip'.tr,
                    ),
                     _CustomRowWidget(
                      isLocation: true,
                      name: 'from'.tr,
                      value: 'Mecca Center',
                    ),
                     _CustomRowWidget(
                      isLocation: true,
                      isBackGroundWhite: false,
                      name: 'to'.tr,
                      value: 'King Abdelaziz Univesity',
                    ),
                  ],
                )
            ]),
      ),
    );
  }
}

class _CustomRowWidget extends StatelessWidget {
  final bool isLocation;
  final String name;
  final String value;
  final bool isBackGroundWhite;
  const _CustomRowWidget(
      {this.isLocation = false,
      required this.name,
      required this.value,
      this.isBackGroundWhite = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: isBackGroundWhite ? AppColors.white : AppColors.darkBlue50,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name,
              style: AppFonts.medium.copyWith(
                color: AppColors.darkBlue400,
                fontWeight: FontWeight.w400,
              )),
          !isLocation
              ? Text(value,
                  style: AppFonts.medium.copyWith(
                    color: AppColors.black800,
                    fontWeight: FontWeight.w500,
                  ))
              : Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/red_location.svg',
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        color: AppColors.error500,
                        fontSize: 14.0.sp(context),
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
