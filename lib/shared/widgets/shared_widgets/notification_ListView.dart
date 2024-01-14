import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/user_widgets/bottomNavigationBar.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/notification_card.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: const BottomNavigationBarr(
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
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                color: Colors.white,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          thickness: 1 / 2,
                        ),
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return NotificationCard(
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
