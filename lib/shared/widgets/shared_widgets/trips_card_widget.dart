import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_map_iamge_widget.dart';
import 'package:wosol/shared/widgets/user_widgets/user_trip_detail_widget.dart';

class TripCardWidget extends StatelessWidget {
  // Details
  final String fromLocation;
  final String fromTitle;
  final String toLocation;
  final String toTitle;
  final String date;
  final String fromTime;
  final String toTime;

  final bool withCancel;
  final bool withBorder;
  final void Function()? onCancel;
  final bool isCancel;
  const TripCardWidget(
      {super.key,
      this.withCancel = false,
      this.withBorder = true,
      this.onCancel,
      required this.fromLocation,
      required this.fromTitle,
      required this.toLocation,
      required this.toTitle,
      required this.date,
      required this.fromTime,
      required this.toTime,
      this.isCancel = true});

  @override
  Widget build(BuildContext context) {
    return CustomContainerCardWithBorderWidget(
      height: withCancel ? (295 + 10 + 7) : (236 + 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: [
            const CustomMapImageWidget(image: 'assets/images/map_details.png'),
            const SizedBox(
              height: 17,
            ),
            Expanded(
                child: UserTripDetailWidget(
              fromTime: fromTime,
              toTime: toTime,
              fromLocation: fromLocation,
              fromTitle: fromTitle,
              toLocation: toLocation,
              toTitle: toTitle,
              date: date,
            )),
            if (withCancel)
              withBorder
                  ? DefaultRowButton(
                      text: isCancel ? "cancelTrip".tr : "unCancelTrip".tr,
                      height: 42,
                      border: Border.all(
                        color: AppColors.error600,
                      ),
                      color: AppColors.white,
                      function: onCancel,
                      textColor: AppColors.error600,
                      borderRadius: 8,
                      containIcon: true,
                      svgPic: 'assets/icons/close_red.svg',
                    )
                  : DefaultRowButton(
                      text: isCancel ? "cancelTrip".tr : "unCancelTrip".tr,
                      height: 42,
                      color: AppColors.error600,
                      function: onCancel,
                      borderRadius: 8,
                      containIcon: true,
                      svgPic: 'assets/icons/close_white.svg',
                    )
          ],
        ),
      ),
    );
  }
}
