import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/user_controllers/user_change_days_controller.dart';
import 'package:wosol/models/change_days_model.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

class UpdateChangeDaysScreen extends StatelessWidget {
  final ChangeDaysModel changeDaysModel;
  final int index;
  final UserChangeDaysController controller;
  UpdateChangeDaysScreen(
      {super.key,
      required this.changeDaysModel,
      required this.controller,
      required this.index});

  final startTimeTextEditingController = TextEditingController();
  final endTimeTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    startTimeTextEditingController.text = changeDaysModel.time1;
    endTimeTextEditingController.text = changeDaysModel.time2;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomHeaderWithBackButton(
              header: "Update Time".tr,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    CustomTextField(
                      validate: true,
                      hint: "Start Time".tr,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.calendar_month_outlined),
                      ),
                      textEditingController: startTimeTextEditingController,
                      onSubmit: (val) {},
                      label: "Start Time".tr,
                      expands: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      validate: true,
                      hint: "End Time".tr,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.calendar_month_outlined),
                      ),
                      textEditingController: endTimeTextEditingController,
                      onSubmit: (val) {},
                      label: "End Time".tr,
                      expands: false,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Obx(() => controller.changeDaysUpdateLoading.value &&
                            controller.selectedDayUpdateIndex.value == index
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.success600,
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success600,
                              foregroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.white),
                              shape: const StadiumBorder(),
                              elevation: 1,
                              minimumSize: Size(Get.width - 100, 40),
                              maximumSize: Size(Get.width - 100, 40),
                              padding: const EdgeInsets.all(0),
                              textStyle: AppFonts.style12Urb
                                  .copyWith(color: AppColors.black),
                            ),
                            onPressed: () async {
                              controller.selectedDayUpdateIndex.value = index;

                              await controller.changeDaysUpdate(
                                  context: context,
                                  changeDaysModel: ChangeDaysModel(
                                      dayId: changeDaysModel.dayId,
                                      orderId: changeDaysModel.orderId,
                                      dayName: changeDaysModel.dayName,
                                      time1:
                                          startTimeTextEditingController.text,
                                      time2:
                                          endTimeTextEditingController.text));
                              if (controller.changeDaysUpdateDone.value &&
                                  context.mounted) {
                                controller.getChangeDays(context: context);
                              }
                            },
                            child: Text("update".tr))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
