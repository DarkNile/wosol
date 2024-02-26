import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/bottom_sheets.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/trips_card_widget.dart';
import '../../../controllers/user_controllers/user_home_controller.dart';
import '../../../shared/constants/constants.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final UserHomeController userHomeController =
      Get.put<UserHomeController>(UserHomeController());

  @override
  void initState() {
    log("user");
    userHomeController.getTrips();
    userHomeController.getCalendarData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeader(
            header: AppConstants.userRepository.userData.userFname,
            svgIcon: "",
            iconWidth: 0,
            iconHeight: 0,
            isHome: true,
          ),
          Obx(() {
            return Expanded(
              child: SingleChildScrollView(
                physics: const PageScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "nextRide".tr,
                      style: AppFonts.header,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    userHomeController.isGettingTrips.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : userHomeController.tripsList.isEmpty
                            ? Center(
                                child: Text(
                                  "No Trips".tr,
                                  style: AppFonts.medium,
                                ),
                              )
                            : Column(
                                children: [
                                  ...List.generate(
                                    userHomeController.tripsList.length <= 2
                                        ? userHomeController.tripsList.length
                                        : 2,
                                    (index) => Column(
                                      children: [
                                        ...List.generate(
                                          userHomeController.tripsList[index]
                                                      .subData!.length <=
                                                  2
                                              ? userHomeController
                                                  .tripsList[index]
                                                  .subData!
                                                  .length
                                              : 2,
                                          (indexSubData) => TripCardWidget(
                                            isCancel: userHomeController
                                                    .tripsList[index]
                                                    .subData![indexSubData]
                                                    .cancelRequest! ==
                                                "0",
                                            withCancel: true,
                                            withBorder: false,
                                            onCancel: () async {
                                              onTapCancel(
                                                  context: context,
                                                  isTrip: true,
                                                  isCancel: userHomeController
                                                          .tripsList[index]
                                                          .subData![
                                                              indexSubData]
                                                          .cancelRequest! ==
                                                      "0",
                                                  tripDate: userHomeController
                                                      .tripsList[index]
                                                      .subData![indexSubData]
                                                      .tripDate!,
                                                  userId: userHomeController
                                                      .tripsList[index]
                                                      .subData![indexSubData]
                                                      .userId!);
                                            },
                                            fromLocation: userHomeController
                                                .tripsList[index]
                                                .subData![indexSubData]
                                                .from!,
                                            fromTitle: userHomeController
                                                .tripsList[index]
                                                .subData![indexSubData]
                                                .from!,
                                            toLocation: userHomeController
                                                .tripsList[index]
                                                .subData![indexSubData]
                                                .universityName!,
                                            toTitle: userHomeController
                                                .tripsList[index]
                                                .subData![indexSubData]
                                                .universityName!,
                                            date: userHomeController
                                                .tripsList[index].date!,
                                            fromTime: userHomeController
                                                .tripsList[index].startTime!,
                                            toTime: userHomeController
                                                .tripsList[index].endTime!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                    Padding(
                      padding: AppConstants.edge(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 10,
                        ),
                      ),
                      child: Text(
                        "thisWeekTrips".tr,
                        style: AppFonts.header,
                      ),
                    ),
                    userHomeController.isGettingCalendar.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : (userHomeController.calendarData.isEmpty ||
                                userHomeController
                                    .calendarData[0].subData!.isEmpty)
                            ? Center(
                                child:
                                    Text("No Trips".tr, style: AppFonts.medium),
                              )
                            : Column(
                                children: [
                                  ...List.generate(
                                      userHomeController.calendarData.length <=
                                              5
                                          ? userHomeController
                                              .calendarData.length
                                          : 5,
                                      (index) => Column(
                                            children: [
                                              ...List.generate(
                                                userHomeController
                                                    .calendarData[index]
                                                    .subData!
                                                    .length,
                                                (indexSubData) =>
                                                    TripCardWidget(
                                                  isCancel: userHomeController
                                                          .calendarData[index]
                                                          .subData![
                                                              indexSubData]
                                                          .cancelRequest! ==
                                                      "0",
                                                  fromLocation:
                                                      userHomeController
                                                          .calendarData[index]
                                                          .subData![
                                                              indexSubData]
                                                          .from!,
                                                  fromTitle: userHomeController
                                                      .calendarData[index]
                                                      .subData![indexSubData]
                                                      .from!,
                                                  toLocation: userHomeController
                                                      .calendarData[index]
                                                      .subData![indexSubData]
                                                      .universityName!,
                                                  toTitle: userHomeController
                                                      .calendarData[index]
                                                      .subData![indexSubData]
                                                      .universityName!,
                                                  date: userHomeController
                                                      .calendarData[index]
                                                      .subData![indexSubData]
                                                      .date!,
                                                  fromTime: userHomeController
                                                      .calendarData[index]
                                                      .startTime!,
                                                  toTime: userHomeController
                                                      .calendarData[index]
                                                      .endTime!,
                                                  withCancel: true,
                                                  onCancel: () async {
                                                    onTapCancel(
                                                      context: context,
                                                      calendarDate:
                                                          userHomeController
                                                              .calendarData[
                                                                  index]
                                                              .subData![
                                                                  indexSubData]
                                                              .date!,
                                                      userId: userHomeController
                                                          .calendarData[index]
                                                          .subData![
                                                              indexSubData]
                                                          .userId!,
                                                      isTrip: false,
                                                      isCancel: userHomeController
                                                              .calendarData[
                                                                  index]
                                                              .subData![
                                                                  indexSubData]
                                                              .cancelRequest! ==
                                                          "0",
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                ],
                              ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> onTapCancel({
    required BuildContext context,
    required bool isTrip,
    String? tripDate,
    String? calendarDate,
    required bool isCancel,
    required String userId,
  }) async {
    showModalBottomSheet(
        context: context,
        builder: (context) => Obx(
              () => RideCanceledAndReportedBottomSheet(
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
                    (!isTrip &&
                        userHomeController.calendarCancelByDateLoading.value),
                firstButtonFunction: () async {
                  log("UserID $userId");
                  log("isCancel $isCancel");
                  if (isTrip) {
                    //  Cancel
                    if (isCancel) {
                      await userHomeController.tripCancelByDateAPI(
                        context: context,
                        userId: userId,
                        date: tripDate!,
                        cancel: '1',
                        cancelReason: 'سبب الالغاء',
                      );
                    } else {
                      // Un Cancel
                      await userHomeController.tripCancelByDateAPI(
                        context: context,
                        userId: userId,
                        date: tripDate!,
                        cancel: '0',
                      );
                    }
                  } else {
                    //  Cancel
                    if (isCancel) {
                      await userHomeController.calendarCancelByDateAPI(
                        context: context,
                        userId: userId,
                        date: calendarDate!,
                        cancel: '1',
                        cancelReason: 'سبب الالغاء',
                      );
                    } else {
                      /// Un Cancel
                      await userHomeController.calendarCancelByDateAPI(
                        context: context,
                        userId: userId,
                        date: calendarDate!,
                        cancel: '0',
                      );
                    }
                  }
                },
                secondButtonFunction: () {
                  Get.back();
                },
              ),
            ));
  }
}
