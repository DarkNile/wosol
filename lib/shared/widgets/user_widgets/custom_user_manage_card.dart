import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/user_controllers/user_home_controller.dart';
import 'package:wosol/models/manage_trips_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_arrow_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_setting_row.dart';

import '../shared_widgets/bottom_sheets.dart';

// ignore: must_be_immutable
class CustomUserManageCardWidget extends StatelessWidget {
  final bool hasHint;
  final bool hasButton;
  final bool isCancel;
  final void Function()? buttonFunction;
  final UserHomeController userHomeController;
  final String userId;
  final String calenderId;
  final String calenderDate;

  final ManageTripsModel manageTrips;

  CustomUserManageCardWidget({
    super.key,
    this.hasHint = false,
    this.hasButton = false,
    this.isCancel = true,
    // required this.userManageTripsController,
    required this.manageTrips,
    required this.userHomeController,
    this.buttonFunction,
    required this.userId,
    required this.calenderId,
    required this.calenderDate,
  });

  RxBool withHint = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomContainerCardWithBorderWidget(
        height: withHint.value || hasHint
            ? 110
            : hasButton
                ? 134
                : 86,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 12, vertical: hasButton || hasHint ? 15 : 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomSettingRowWidget(
                    isSwitcher: true,
                    isManageScreen: true,
                    isSwitcherOn: manageTrips.isToggleOn.value,
                    toggleIcon: () {
                      onTapCancel(
                        calendarDate: calenderDate,
                        context: context,
                        calendarId: calenderId,
                        userId: userId,
                        isTrip: false,
                        isCancel: manageTrips.isToggleOn.value,
                      );
                    },
                    title: '${manageTrips.time} ${"am".tr}',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: CustomRowWithArrowWidget(
                    isHeader: false,
                    from: manageTrips.from,
                    to: manageTrips.to,
                  ),
                ),
                if (hasHint || withHint.value) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/hint.svg',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text('${"nextTripWillBeOn".tr} Jan 03, 2023',
                            style: AppFonts.small.copyWith(
                              color: AppColors.logo,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ))
                      ],
                    ),
                  ),
                ],
                if ((!withHint.value) && hasButton) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  DefaultRowButton(
                      height: 42,
                      containIcon: true,
                      svgPic: 'assets/icons/refresh.svg',
                      fontSize: 14,
                      text:
                          '${"turnBackOnFor".tr} Jan 03, 2023 ${AppConstants.isEnLocale ? "?" : "؟"}',
                      borderRadius: 8,
                      function: buttonFunction ??
                          () {
                            withHint.value = true;
                          }),
                ]
              ]),
        ),
      ),
    );
  }

  Future<void> onTapCancel({
    required BuildContext context,
    required bool isTrip,
    String? tripDate,
    required String calendarId,
    required String calendarDate,
    required bool isCancel,
    required String userId,
  }) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Obx(
              () => RideCanceledAndReportedBottomSheet(
                showOrButton: true,
                isCancel: isCancel,
                headTitle: isCancel ? 'Cancel Ride'.tr : 'Un Cancel Ride'.tr,
                isCancelFirstStep: true,
                imagePath: 'assets/images/thinking.png',
                headerMsg: isCancel
                    ? 'You are about to cancel your ride, are you sure?'.tr
                    : 'You are about to unCancel your ride, are you sure?'.tr,
                subHeaderMsg: isCancel
                    ? 'Note: today trip only will be canceled'.tr
                    : 'Note: today trip only will be uncanceled'.tr,
                firstButtonLoading: (isTrip &&
                        userHomeController.tripCancelByDateLoading.value) ||
                    (!isTrip && userHomeController.calendarCancelLoading.value),
                firstButtonFunction: () async {
                  //  Cancel
                  if (isCancel) {
                    await userHomeController
                        .calendarCancelAPI(
                          context: context,
                          userId: userId,
                          calendarId: calendarId,
                          cancel: '1',
                          cancelReason: 'سبب الالغاء',
                        )
                        .then(
                          (value) => manageTrips.isToggleOn.value = false,
                        );
                  } else {
                    /// Un Cancel
                    await userHomeController
                        .calendarCancelAPI(
                          context: context,
                          userId: userId,
                          calendarId: calendarId,
                          cancel: '0',
                        )
                        .then(
                          (value) => manageTrips.isToggleOn.value = true,
                        );
                  }
                },
                secondButtonFunction: () {
                  Get.back();
                },
                thirdButtonLoading:
                    userHomeController.calendarCancelByDateLoading.value,
                thirdButtonFunction: () async {
                  if (manageTrips.isToggleOn.value) {
                    await userHomeController.calendarCancelByDateAPI(
                      context: context,
                      userId: userId,
                      date: calenderDate,
                      cancel: '1',
                      cancelReason: 'سبب الالغاء',
                    );
                  } else {
                    await userHomeController.calendarCancelByDateAPI(
                      context: context,
                      userId: userId,
                      date: calenderDate,
                      cancel: '0',
                    );
                  }
                },
              ),
            ));
  }
}
