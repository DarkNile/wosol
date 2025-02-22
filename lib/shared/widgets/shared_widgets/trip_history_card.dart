import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_map_iamge_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_arrow_widget.dart';

import 'buttons.dart';

class TripHistoryCard extends StatelessWidget {
  const TripHistoryCard({
    super.key,
    required this.date,
    required this.fromCity,
    required this.toCity,
    required this.onTap,
    required this.buttonText,
    this.middleWidget,
    this.height,
    this.isEmployee = false,
    this.sEOnTap,
  });
  final String date;

  final String fromCity;
  final String toCity;
  final String buttonText;
  final void Function() onTap;
  final void Function()? sEOnTap;
  final Widget? middleWidget;
  final double? height;
  final bool isEmployee;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEmployee? null : onTap,
      child: CustomContainerCardWithBorderWidget(
        height: isEmployee? 270: height,
        child: Padding(
          padding: AppConstants.edge(padding: const EdgeInsets.all(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomMapImageWidget(
                image: "assets/images/map_details.png",
              ),
              const SizedBox(height: 12),
              CustomRowWithArrowWidget(
                from: fromCity,
                to: toCity,
              ),
              const SizedBox(height: 8),
              middleWidget ??
                  Text(
                    date,
                    style:
                        AppFonts.small.copyWith(color: AppColors.darkBlue300),
                  ),
              const SizedBox(height: 8),
              CustomRowWithArrowWidget(
                from: buttonText,
                to: 'toCity',
                isHeader: false,
                isButton: true,
              ),
              if(isEmployee)
                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        height: 48,
                        marginLeft: 8,
                        marginRight: 8,
                        marginTop: 14,
                        function: onTap,
                        text: 'viewTripRoute'.tr,
                      ),
                    ),
                    Expanded(
                      child: DefaultButton(
                        height: 48,
                        marginLeft: 8,
                        marginRight: 8,
                        marginTop: 14,
                        function: sEOnTap!,
                        text: 'viewTripDetails'.tr,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
