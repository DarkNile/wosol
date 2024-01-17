import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeaderWithOptionalWidget(
          screenTitle: "Notifications".tr,
          isWithBackArrow: false,
          suffixWidget: SvgPicture.asset("assets/icons/search_icon.svg"),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Container(
              color: AppColors.white,
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        color: AppColors.dividerColor,
                      ),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return NotificationCard(
                      color: (index == 0 || index == 2)
                          ? AppColors.btnBackColor
                          : AppColors.white,
                      notificationTime: AppConstants.isEnLocale
                          ? "15 ${"minsAgo".tr}"
                          : "${"ago".tr} 15 ${"mins".tr}",
                      notificationTitle:
                          "from Home to King Abdelaziz University",
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
