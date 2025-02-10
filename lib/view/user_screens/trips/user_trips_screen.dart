import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

import '../../../controllers/user_controllers/user_layout_controller.dart';
import '../../../shared/widgets/shared_widgets/trips_card_widget.dart';

class UserTripsScreen extends StatefulWidget {
  const UserTripsScreen({super.key});

  @override
  State<UserTripsScreen> createState() => _UserTripsScreenState();
}

class _UserTripsScreenState extends State<UserTripsScreen> {
  UserLayoutController userLayoutController = Get.find<UserLayoutController>();

  @override
  void initState() {
    userLayoutController.getStudentRoutes();
    super.initState();
  }

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
            CustomHeaderWithBackButton(header: "trips".tr),
            Obx(() {
              return userLayoutController.isGettingStudentRoutes.value
                  ? const Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: 18.0),
                          child: CircularProgressIndicator()),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        physics: const PageScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                                userLayoutController.studentRoutes.length,
                                (index) => TripCardWidget(
                                      isOldDate: false,
                                      tripId: userLayoutController
                                          .studentRoutes[index]
                                          .subData
                                          .first
                                          .tripId,
                                      // driverPhoneNumber: userLayoutController
                                      //     .studentRoutes[index]
                                      //     .subData
                                      //     .first.driverPhone,
                                      fromLocation: userLayoutController
                                          .studentRoutes[index]
                                          .subData
                                          .first
                                          .from,
                                      fromTitle: userLayoutController
                                          .studentRoutes[index]
                                          .subData
                                          .first
                                          .address,
                                      toLocation: userLayoutController
                                          .studentRoutes[index]
                                          .subData
                                          .first
                                          .to,
                                      toTitle: userLayoutController
                                          .studentRoutes[index]
                                          .subData
                                          .first
                                          .address,
                                      date: userLayoutController
                                          .studentRoutes[index]
                                          .subData
                                          .first
                                          .tripDate,
                                      fromTime:
                                          AppConstants.getTimeFromDateString(
                                              userLayoutController
                                                  .studentRoutes[index]
                                                  .subData
                                                  .first
                                                  .tripStart),
                                      toTime:
                                          AppConstants.getTimeFromDateString(
                                              userLayoutController
                                                  .studentRoutes[index]
                                                  .subData
                                                  .first
                                                  .tripStart),
                                    )),
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
}
