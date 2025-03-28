import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/shared_controllers/notification_controller/notification_controller.dart';
import 'package:wosol/models/notification_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationController notifyController = Get.put(NotificationController())
      ..getNotifications();
    return SafeArea(
      child: Column(
        children: [
          CustomHeaderWithOptionalWidget(
            screenTitle: "Notifications".tr,
            isWithBackArrow: false,
            // suffixWidget: SvgPicture.asset("assets/icons/search_icon.svg"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Container(
                color: AppColors.white,
                child: Obx(
                  () {
                    print("leee ${notifyController.notifications.length}");
                    if (notifyController.isNotificationsLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return notifyController.notifications.isEmpty
                        ? Center(
                            child: Text(
                            'No Notifications!'.tr,
                            style:
                                AppFonts.medium.copyWith(color: AppColors.logo),
                          ))
                        : ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                                  height: 1,
                                  color: AppColors.dividerColor,
                                ),
                            shrinkWrap: true,
                            itemCount: notifyController.notifications.length,
                            itemBuilder: (context, index) {
                              NotificationModel notification =
                                  notifyController.notifications[index];
                              bool isRead = notification.read == "1";
                              return NotificationCard(
                                color: !isRead
                                    ? AppColors.btnBackColor
                                    : AppColors.white,
                                notificationTime: AppConstants.isEnLocale
                                    ? "15 ${"minsAgo".tr}"
                                    : "${"ago".tr} 15 ${"min".tr}",
                                notificationTitle: notification.text ?? "",
                                onSelected: (String value) async {
                                  if (value == "MarkAsRead") {
                                    notifyController
                                        .isNotificationsLoading.value = true;
                                    await notifyController.notificationSetRead(
                                        notificationId: notification.nId!,
                                        );
                                    notifyController.notifications[index].read =
                                        "1";
                                    notifyController
                                        .isNotificationsLoading.value = false;
                                    Get.back();
                                  } else {
                                    Get.back();
                                  }
                                },
                              );
                            });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
