import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
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
  final void Function()? onViewMap;
  final bool isCancel;
  final bool isOldDate;
  final bool tripIsRunning;
  final String tripId;
  // final String? driverPhoneNumber;

  const TripCardWidget({
    super.key,
    this.withCancel = false,
    required this.isOldDate,
    this.withBorder = true,
    this.onCancel,
    this.onViewMap,
    required this.fromLocation,
    required this.fromTitle,
    required this.toLocation,
    required this.toTitle,
    required this.date,
    required this.fromTime,
    required this.toTime,
    this.isCancel = true,
    this.tripIsRunning = false,
    required this.tripId,
    // this.driverPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainerCardWithBorderWidget(
      height: withCancel && !isOldDate ? (296 + 10 + 7) : (254 + 24 + 10 + 30),
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
              tripId: tripId,
            )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         launchUrl(Uri.parse(
            //             "https://wa.me/${'+966 $driverPhoneNumber'}"));
            //       },
            //       child: Container(
            //         width: 155,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(6),
            //           color: AppColors.orange.withOpacity(0.1),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text('call the driver'.tr,
            //                 style: AppFonts.button.copyWith(
            //                     fontSize: 13, color: AppColors.black800)),
            //             const SizedBox(
            //               width: 4,
            //             ),
            //             SvgPicture.asset(
            //                 width: 24, height: 24, 'assets/icons/msg.svg')
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            if (withCancel)
              Row(
                children: [
                  if (tripIsRunning)
                    Expanded(
                      child: DefaultRowButton(
                        text: "goToMap".tr,
                        height: 42,
                        border: withBorder
                            ? Border.all(
                                color: AppColors.error600,
                              )
                            : null,
                        color: AppColors.logo,
                        function: onViewMap,
                        textColor:
                            withBorder ? AppColors.error600 : AppColors.white,
                        borderRadius: 8,
                        containIcon: false,
                        svgPic: withBorder
                            ? 'assets/icons/close_red.svg'
                            : 'assets/icons/close_white.svg',
                      ),
                    ),
                  if (tripIsRunning)
                    const SizedBox(
                      width: 16,
                    ),
                  if (!isOldDate)
                    Expanded(
                      child: DefaultRowButton(
                        text: isCancel ? "cancelTrip".tr : "unCancelTrip".tr,
                        height: 42,
                        border: withBorder
                            ? Border.all(
                                color: AppColors.error600,
                              )
                            : null,
                        color:
                            withBorder ? AppColors.white : AppColors.error600,
                        function: onCancel,
                        textColor:
                            withBorder ? AppColors.error600 : AppColors.white,
                        borderRadius: 8,
                        containIcon: true,
                        svgPic: withBorder
                            ? 'assets/icons/close_red.svg'
                            : 'assets/icons/close_white.svg',
                      ),
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
