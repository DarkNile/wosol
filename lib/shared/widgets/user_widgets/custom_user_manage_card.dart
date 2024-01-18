import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/models/manage_trips_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_arrow_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_setting_row.dart';

import '../../../controllers/user_controllers/manage_trips_controller.dart';

// ignore: must_be_immutable
class CustomUserManageCardWidget extends StatelessWidget {
  final bool hasHint;
  final bool hasButton;
  final void Function()? buttonFunction;
  final UserManageTripsController userManageTripsController;
  final ManageTripsModel manageTrips;

  CustomUserManageCardWidget({
    super.key,
    this.hasHint = false,
    this.hasButton = false,
    required this.userManageTripsController,
    required this.manageTrips,
    this.buttonFunction,
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
                    toggleIcon: () => userManageTripsController
                        .changeToggleValue(manageTrips),
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
}
