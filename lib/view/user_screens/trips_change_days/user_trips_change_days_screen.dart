import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/user_controllers/user_change_days_controller.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/view/user_screens/trips_change_days/change_days_card.dart';

class UserTripsChangeDaysScreen extends StatelessWidget {
  const UserTripsChangeDaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserChangeDaysController controller =
        Get.put(UserChangeDaysController());
    controller.getChangeDays(context: context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(children: [
          CustomHeaderWithBackButton(
            header: "myCalendar".tr,
          ),
          Expanded(
            child: Obx(
              () => controller.getChangeDaysLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.changeDaysList.isEmpty
                      ? Center(child: Text('noData'.tr))
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 12)
                              .copyWith(bottom: 16, top: 8),
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemCount: controller.changeDaysList.length,
                          itemBuilder: (context, index) {
                            return ChangeDaysCardWidget(
                              index: index,
                              controller: controller,
                              changeDaysModel: controller.changeDaysList[index],
                            );
                          },
                        ),
            ),
          ),
        ]),
      ),
    );
  }
}
