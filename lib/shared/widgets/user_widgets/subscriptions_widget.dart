import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:wosol/models/subscription_model.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

import '../../constants/constants.dart';

// ignore: must_be_immutable
class SubscriptionsWidget extends StatelessWidget {
  // Put Model Here
  SubscriptionsWidget({super.key, required this.subscriptionModel});
  final SubscriptionModel subscriptionModel;

  double height = 62;
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_, setState) => Container(
        height: isExpanded ? 378 : 64,
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
                      Text('ID #${subscriptionModel.id}',
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
                      value: '${subscriptionModel.price} ${"SAR".tr}',
                    ),
                    _CustomRowWidget(
                      isBackGroundWhite: false,
                      name: 'startDate'.tr,
                      value: DateFormat(
                          'dd, MMM, yyyy',
                          AppConstants
                              .isEnLocale
                              ? 'en_US'
                              : "ar")
                          .format(DateTime.parse(subscriptionModel.startDate!)),
                    ),
                    _CustomRowWidget(
                      name: 'endDate'.tr,
                      value: DateFormat(
                          'dd, MMM, yyyy',
                          AppConstants
                              .isEnLocale
                              ? 'en_US'
                              : "ar")
                          .format(DateTime.parse(subscriptionModel.endDate!)),
                    ),
                    _CustomRowWidget(
                      isBackGroundWhite: false,
                      name: 'tripType'.tr,
                      value: subscriptionModel.tripType!,
                    ),
                    _CustomRowWidget(
                      isLocation: true,
                      name: 'from'.tr,
                      value: subscriptionModel.from!,
                    ),
                    _CustomRowWidget(
                      isLocation: true,
                      isBackGroundWhite: false,
                      name: 'to'.tr,
                      value: subscriptionModel.to!,
                    ),
                    _CustomRowWidget(
                      name: 'remainingDays'.tr,
                      value: '${subscriptionModel.remainingDays}',
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
                    Text(value,
                        style: AppFonts.medium.copyWith(
                          color: AppColors.error500,
                          fontWeight: FontWeight.w500,
                        )
                        // const TextStyle(
                        // decoration: TextDecoration.underline,
                        // ),
                        ),
                  ],
                )
        ],
      ),
    );
  }
}
