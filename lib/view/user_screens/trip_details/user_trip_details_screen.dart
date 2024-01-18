import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/bottom_sheets.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/tripDetailsCard.dart';
import 'package:wosol/view/user_screens/trip_details/widget/rate_card_widget.dart';

class UserTripDetailsScreen extends StatelessWidget {
  const UserTripDetailsScreen({super.key});

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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TripDetailsCard(
                      date: 'Dec 22  - 08:10 am',
                      fromCity:
                          'Mecca Center, FR8C+HXF, At Taniem, Makkah 24224, Saudi Arabia',
                      toCity:
                          'King Abelaziz Usiversity, F6QV+J49, Unnamed Road King Abdulaziz University, Jeddah 21589, Saudi Arabia',
                      isCaptain: false,
                    ),
                    customDivider(),
                    const RateCardWidget(),
                    customDivider(),
                    RateCardWidget(
                        withRateButton: true,
                        onRateTap: () async {
                          await onRateTap(context);
                        }),
                    customDivider(),
                    DefaultRowButton(
                        color: Colors.transparent,
                        text: 'reportAProblem'.tr,
                        textColor: AppColors.error600,
                        fontSize: 14,
                        containIcon: true,
                        svgPic: "assets/icons/flag.svg",
                        function: () async {
                          await onReport(context);
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onRateTap(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => RateBottomSheet(
            function: () {
              Get.back();
              showModalBottomSheet(
                  context: context,
                  builder: (context) => RideCanceledAndReportedBottomSheet(
                      headTitle: 'Ride Reported'.tr,
                      imagePath: 'assets/images/star.png',
                      headerMsg: 'Rated submitted successfully'.tr,
                      subHeaderMsg:
                          'Thank you, hope you have enjoyed your ride with us'
                              .tr,
                      isReportFirstStep: true));
            },
            onRatingUpdate: (double rate) {},
            headTitle: 'Rate your trip'.tr,
            selectIssue: false));
  }

  onReport(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => CancellationReasonAndReportRideBottomSheet(
              function: () {
                Get.back();
                showModalBottomSheet(
                    context: context,
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
