import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/view/captain_screens/bottom_nav_bar_captain.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/notification_card.dart';

// Todo : Should be NotificationScreen
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: const BottomNavigationBarCaptain(
        index: 2,
      ),
      body: Column(
        children: [
          CustomHeaderWithOptionalWidget(
            screenTitle: "Notifications".tr,
            isWithBackArrow: false,
            suffixWidget: SvgPicture.asset("assets/icons/search_icon.svg"),
          ),
          Expanded(
            child: Padding(
              // Todo : padding top should be 13 not 16 look at figma please
              padding: const EdgeInsets.only(top: 13.0),
              child: Container(
                // Todo : Hard Color
                color: AppColors.white,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          height: 1,
                          color: AppColors.dividerColor,
                        ),
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return const NotificationCard(
                        notificationTime: "15 min ago",
                        notificationTitle:
                            "from Home to King Abdelaziz University",
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
