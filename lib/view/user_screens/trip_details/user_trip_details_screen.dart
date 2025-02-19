import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/user_controllers/trip_history_student_controller.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/bottom_sheets.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/shared/widgets/shared_widgets/tripDetailsCard.dart';
import 'package:wosol/view/user_screens/trip_details/widget/rate_card_widget.dart';

import '../../../models/trip_history_student_model.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/widgets/shared_widgets/custom_check_tile.dart';

class UserTripDetailsScreen extends StatelessWidget {
  UserTripDetailsScreen({
    super.key,
    required this.dateTime,
    required this.from,
    required this.to,
    required this.captainName,
    required this.userId,
    required this.tripId,
    required this.tripUserId,
    required this.tripType,
    required this.isRated,
  });

  final String dateTime;
  final String from;
  final String to;
  final String captainName;
  final String userId;
  final String tripId;
  final String tripUserId;
  final String tripType;
  final bool isRated;

  final TripHistoryStudentController tripHistoryStudentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderWithBackButton(
              header: "tripDetails".tr,
            ),
            const SizedBox(
              height: 14,
            ),
            GetBuilder<TripHistoryStudentController>(builder: (_) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TripDetailsCard(
                        date: dateTime,
                        fromCity: from,
                        toCity: to,
                        captainName: captainName,
                        isCaptain: false,
                      ),
                      // customDivider(),
                      // const RateCardWidget(),
                      customDivider(),
                      if (!isRated)
                        RateCardWidget(
                          withRateButton: true,
                          onRateTap: () async {
                            await onRateTap(
                              context,
                              tripHistoryStudentController.tripRateController,
                              (double rate) {
                                tripHistoryStudentController.tripRate = rate;
                                tripHistoryStudentController.update();
                              },
                            );
                          },
                          title: 'rateTrip'.tr,
                          isRated: tripHistoryStudentController.tripRate != -1,
                          rate: tripHistoryStudentController.tripRate,
                        ),
                      if (!isRated)
                        RateCardWidget(
                          withRateButton: true,
                          onRateTap: () async {
                            await onRateTap(
                              context,
                              tripHistoryStudentController.driverRateController,
                              (double rate) {
                                tripHistoryStudentController.driverRate = rate;
                                tripHistoryStudentController.update();
                              },
                            );
                          },
                          title: 'rateDriver'.tr,
                          isRated:
                              tripHistoryStudentController.driverRate != -1,
                          rate: tripHistoryStudentController.driverRate,
                        ),
                      if (!isRated)
                        RateCardWidget(
                          withRateButton: true,
                          onRateTap: () async {
                            await onRateTap(
                              context,
                              tripHistoryStudentController
                                  .vehicleRateController,
                              (double rate) {
                                tripHistoryStudentController.vehicleRate = rate;
                                tripHistoryStudentController.update();
                              },
                            );
                          },
                          title: 'rateVehicle'.tr,
                          isRated:
                              tripHistoryStudentController.vehicleRate != -1,
                          rate: tripHistoryStudentController.vehicleRate,
                        ),
                      if (!isRated &&
                          (tripHistoryStudentController.tripRate != -1 ||
                              tripHistoryStudentController.driverRate != -1 ||
                              tripHistoryStudentController.vehicleRate != -1))
                        DefaultButton(
                          loading:
                              tripHistoryStudentController.addRateLoading.value,
                          height: 48,
                          marginLeft: 24,
                          marginRight: 24,
                          marginTop: 14,
                          function: () {
                            tripHistoryStudentController.addRate(
                              tripId: tripId,
                              tripUserId: tripUserId,
                              tripType: tripType,
                              userId: userId,
                            );
                          },
                          text: 'sendRate'.tr,
                        ),
                      if (!isRated)
                      customDivider(),
                      if (!isRated)
                      DefaultRowButton(
                          color: Colors.transparent,
                          text: 'reportAProblem'.tr,
                          textColor: AppColors.error600,
                          fontSize: 14,
                          containIcon: true,
                          svgPic: "assets/icons/flag.svg",
                          function: () async {
                            tripHistoryStudentController
                                .getReportReasons()
                                .then((_) {
                              if (context.mounted) {
                                showModalBottomSheet(
                                    context: context,
                                    isDismissible: false,
                                    enableDrag: false,
                                    builder: (context) => BottomSheetBase(
                                          headTitle: 'Report ride'.tr,
                                          buttonsContainIcon: false,
                                          withCloseIcon: true,
                                          showButtons: false,
                                          height: 350,
                                          child: GetBuilder<
                                              TripHistoryStudentController>(
                                            builder: (_) =>
                                                tripHistoryStudentController
                                                        .isGettingReportReasons
                                                        .value
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : Column(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  ...List
                                                                      .generate(
                                                                    tripHistoryStudentController
                                                                        .reportReasonsModel!
                                                                        .data
                                                                        .length,
                                                                    (index) =>
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              8),
                                                                      child:
                                                                          CustomCheckTileWidget(
                                                                        onTap:
                                                                            () {
                                                                          tripHistoryStudentController.selectedReportReason = tripHistoryStudentController
                                                                              .reportReasonsModel!
                                                                              .data[index];
                                                                          tripHistoryStudentController
                                                                              .update();
                                                                        },
                                                                        isChecked:
                                                                            tripHistoryStudentController.selectedReportReason ==
                                                                                tripHistoryStudentController.reportReasonsModel!.data[index],
                                                                        title: AppConstants.isEnLocale
                                                                            ? tripHistoryStudentController.reportReasonsModel!.data[index].reportEn!
                                                                            : tripHistoryStudentController.reportReasonsModel!.data[index].reportAr!,
                                                                        withCircularCheckBox:
                                                                            true,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 14,
                                                                  ),
                                                                  CustomTextField(
                                                                    validate:
                                                                        true,
                                                                    height: 60,
                                                                    textEditingController:
                                                                        tripHistoryStudentController
                                                                            .reportController,
                                                                    onSubmit:
                                                                        (val) {},
                                                                    label:
                                                                        'Message(optional)'
                                                                            .tr,
                                                                    hint:
                                                                        'enter your message'
                                                                            .tr,
                                                                    expands:
                                                                        true,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          DefaultButton(
                                                            loading:
                                                                tripHistoryStudentController
                                                                    .addReportLoading
                                                                    .value,
                                                            height: 48,
                                                            marginTop: 14,
                                                            function: () {
                                                              tripHistoryStudentController
                                                                  .addReport(
                                                                userId: userId,
                                                                tripId: tripId,
                                                                tripUserId:
                                                                    tripUserId,
                                                                tripType:
                                                                    tripType,
                                                              );
                                                            },
                                                            text: 'Send'.tr,
                                                          ),
                                                        ],
                                                      ),
                                          ),
                                        ));
                              }
                            });
                          }),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  onRateTap(BuildContext context, TextEditingController controller,
      Function(double rate) onRatingUpdate) async {
    await showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => RateBottomSheet(
            function: () {
              Get.back();
              showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  enableDrag: false,
                  isScrollControlled: true,
                  builder: (context) => BottomSheetBase(
                        headTitle: 'Rate your trip'.tr,
                        withCloseIcon: true,
                        firstButtonText: 'Confirm'.tr,
                        firstButtonFunction: () {
                          Get.back();
                        },
                        height: 230,
                        child: CustomTextField(
                          validate: true,
                          textEditingController: controller,
                          onSubmit: (val) {},
                          label: 'addComment'.tr,
                          hint: 'addComment'.tr,
                          expands: false,
                        ),
                      ));
            },
            onRatingUpdate: onRatingUpdate,
            headTitle: 'Rate your trip'.tr,
            selectIssue: false));
  }

  onReport(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        builder: (context) => CancellationReasonAndReportRideBottomSheet(
              function: () {
                Get.back();
                showModalBottomSheet(
                    context: context,
                    isDismissible: false,
                    enableDrag: false,
                    builder: (context) => RideCanceledAndReportedBottomSheet(
                        headTitle: 'Ride Reported'.tr,
                        imagePath: 'assets/images/sad.png',
                        headerMsg: 'We feel sorry for you'.tr,
                        subHeaderMsg:
                            'We received your report successfully, and we will try to resolve the issue very soon.'
                                .tr,
                        isReportFirstStep: true));
              },
              headTitle: 'Report ride'.tr,
              reasons: [
                "Driver behaviour".tr,
                "Driver arrived late".tr,
                "Car propblem".tr,
                "Other".tr
              ],
              containTextField: true,
              reasonsSelectedIndex: 3,
            ));
  }

  Widget customDivider() {
    return const SizedBox(
      height: 10,
    );
  }
}
