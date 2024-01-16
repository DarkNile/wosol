import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/bottom_sheets.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/trips_card_widget.dart';
import '../../../shared/constants/constants.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeader(
          header: "Hossam",
          svgIcon: "",
          iconWidth: 0,
          iconHeight: 0,
          isHome: true,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                TripCardWidget(
                  withCancel: true,
                  withBorder: false,
                  onCancel: () async {
                    onTapCancel(context);
                  },
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
                ...List.generate(
                    5,
                    (index) => TripCardWidget(
                          withCancel: true,
                          onCancel: () async {
                            onTapCancel(context);
                          },
                        )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onTapCancel(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) => RideCanceledAndReportedBottomSheet(
              headTitle: 'Cancel Ride',
              isCancelFirstStep: true,
              imagePath: 'assets/images/thinking.png',
              headerMsg: 'You are about to cancel your ride, are you sure?',
              subHeaderMsg: 'Note: today trip only will be canceled',
              firstButtonFunction: () {
                Get.back();
                showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        const RideCanceledAndReportedBottomSheet(
                          headTitle: 'Ride Canceled',
                          isReportFirstStep: true,
                          imagePath: 'assets/images/smile.png',
                          headerMsg: 'Ride has been canceled',
                          subHeaderMsg:
                              "Thank you for being kind and save others' time.",
                        ));
              },
              secondButtonFunction: () {
                Get.back();
              },
            ));
  }
}
