import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/user_widgets/rating_bar_widget.dart';

class RateCardWidget extends StatelessWidget {
  final bool withRateButton;
  final void Function()? onRateTap;

  const RateCardWidget(
      {super.key, this.withRateButton = false, this.onRateTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: withRateButton ? 86 : 96,
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('rate'.tr,
                style: AppFonts.header
                    .copyWith(fontSize: 14, color: AppColors.black800)),
            const SizedBox(
              height: 6,
            ),
            withRateButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('noRating'.tr,
                          style: AppFonts.medium.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkBlue400,
                          )),
                      DefaultButton(
                          width: 77,
                          text: 'rate'.tr,
                          fontSize: 14,
                          height: 38,
                          borderRadius: 8,
                          border: Border.all(color: AppColors.logo),
                          color: AppColors.btnBackColor,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.logo,
                          function: onRateTap)
                    ],
                  )
                : RatingBarWidget(
                    itemSize: 48,
                    ignoreGestures: true,
                    itemPadding: const EdgeInsets.all(0),
                    onRatingUpdate: (double rate) {},
                  ),
          ],
        ));
  }
}
