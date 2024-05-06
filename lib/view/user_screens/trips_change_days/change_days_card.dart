import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wosol/controllers/user_controllers/user_change_days_controller.dart';
import 'package:wosol/models/change_days_model.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/view/user_screens/trips_change_days/update_change_days_screen.dart';

class ChangeDaysCardWidget extends StatelessWidget {
  final ChangeDaysModel changeDaysModel;
  final int index;
  final UserChangeDaysController controller;
  const ChangeDaysCardWidget(
      {super.key,
      required this.changeDaysModel,
      required this.controller,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        border: Border.all(color: AppColors.logo, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Day
            _CustomRowWidget(
              title: "day".tr,
              value: changeDaysModel.dayName,
            ),
            const SizedBox(
              height: 4,
            ),

            // Start Time
            _CustomRowWidget(
              title: "Start Time".tr,
              value: changeDaysModel.time1,
            ),
            const SizedBox(
              height: 4,
            ),

            // End Time
            _CustomRowWidget(
              title: "End Time".tr,
              value: changeDaysModel.time2,
            ),
            const SizedBox(
              height: 4,
            ),

            (changeDaysModel.requestChange == "1")
                ? Text(
                    "requestUnderReview".tr,
                    style: AppFonts.medium.copyWith(color: AppColors.logo),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success600,
                            foregroundColor: AppColors.white,
                            side: const BorderSide(color: AppColors.white),
                            shape: const StadiumBorder(),
                            elevation: 0,
                            minimumSize: const Size(100, 40),
                            maximumSize: const Size(100, 40),
                            padding: const EdgeInsets.all(0),
                            textStyle: AppFonts.style12Urb
                                .copyWith(color: AppColors.black),
                          ),
                          onPressed: () async {
                            controller.selectedDayUpdateIndex.value = index;
                            Get.to(() => UpdateChangeDaysScreen(
                                  changeDaysModel: changeDaysModel,
                                  controller: controller,
                                  index: index,
                                ));
                          },
                          child: Text("update".tr)),
                      const SizedBox(
                        width: 8,
                      ),
                      Obx(
                        () => controller.changeDaysUpdateLoading.value &&
                                controller.selectedDayCancelIndex.value == index
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.error600,
                                )),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.error600,
                                  foregroundColor: AppColors.white,
                                  side:
                                      const BorderSide(color: AppColors.white),
                                  shape: const StadiumBorder(),
                                  elevation: 0,
                                  minimumSize: const Size(100, 40),
                                  maximumSize: const Size(100, 40),
                                  padding: const EdgeInsets.all(0),
                                  textStyle: AppFonts.style12Urb
                                      .copyWith(color: AppColors.black),
                                ),
                                onPressed: () async {
                                  controller.selectedDayCancelIndex.value =
                                      index;
                                  await controller.changeDaysUpdate(
                                      context: context,
                                      changeDaysModel: ChangeDaysModel(
                                          isOn: "no",
                                          dayId: changeDaysModel.dayId,
                                          orderId: changeDaysModel.orderId,
                                          dayName: changeDaysModel.dayName,
                                          time1: changeDaysModel.time1,
                                          time2: changeDaysModel.time2));

                                  if (context.mounted) {
                                    await controller.getChangeDays(
                                        context: context);
                                  }
                                },
                                child: Text("cancel".tr)),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

class _CustomRowWidget extends StatelessWidget {
  final String title;
  final String value;
  const _CustomRowWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: AppFonts.style12Urb,
      ),
      Text(
        value,
        style: AppFonts.style12Urb,
      ),
    ]);
  }
}
