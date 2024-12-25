import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/user_controllers/user_attendance_controller.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/view/user_screens/attendance/user_attendance_card.dart';

class UserAttendanceScreen extends StatelessWidget {
  UserAttendanceScreen({super.key});

  final UserAttendanceController controller =
      Get.put(UserAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(children: [
          CustomHeaderWithBackButton(
            header: "myAttendance".tr,
          ),
          Expanded(
            child: Obx(
              () => controller.isGettingUseAttendance.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.userAttendanceList.isEmpty
                      ? Center(child: Text('noData'.tr))
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 12)
                              .copyWith(bottom: 16, top: 8),
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemCount: controller.userAttendanceList.length,
                          itemBuilder: (context, index) {
                            return UserAttendanceCardWidget(
                              userAttendanceModel:
                                  controller.userAttendanceList[index],
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
