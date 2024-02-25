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
                child: userHomeController.isGettingCalendar.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
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
            );
          }),
        ],
      ),
    );
  }

  Future<void> onTapCancel(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) => RideCanceledAndReportedBottomSheet(
              headTitle: 'Cancel Ride'.tr,
              isCancelFirstStep: true,
              imagePath: 'assets/images/thinking.png',
              headerMsg: 'You are about to cancel your ride, are you sure?'.tr,
              subHeaderMsg: 'Note: today trip only will be canceled'.tr,
              firstButtonFunction: () async{
                /// todo Put the data here int the 2 functions and the condition if this cancel or not
                await userHomeController.tripCancelByDateAPI(
                  context: context,
                  userId: '247',
                  date: '2024-02-18',
                  cancel: '1',
                  cancelReason: 'سبب الالغاء',
                );
                /// todo not ready from Api
                // await userHomeController.tripCancelByDateAPI(
                //   context: context,
                //   userId: '247',
                //   date: '2024-02-18',
                //   cancel: '0',
                // );
              },
              secondButtonFunction: () {
                Get.back();
              },
            ));
  }
}
