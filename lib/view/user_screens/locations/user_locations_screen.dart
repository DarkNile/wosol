import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/location_card_widget.dart';

import '../../../controllers/user_controllers/user_layout_controller.dart';

class UserLocationsScreen extends StatefulWidget {
  const UserLocationsScreen({super.key});

  @override
  State<UserLocationsScreen> createState() => _UserLocationsScreenState();
}

class _UserLocationsScreenState extends State<UserLocationsScreen> {
  UserLayoutController userLayoutController = Get.find<UserLayoutController>();

  @override
  void initState() {
    userLayoutController.getStudentLocations();
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
            CustomHeaderWithBackButton(
              header: "locations".tr,
            ),
            Obx(() {
              return userLayoutController.isGettingStudentLocation.value
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        if (userLayoutController.studentLocation.homeAddress !=
                            null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 16.0,
                            ),
                            child: LocationCardWidget(
                              title: "Home",
                              address: userLayoutController
                                  .studentLocation.homeAddress!,
                              latLng: LatLng(
                                userLayoutController
                                    .studentLocation.homeLatitude!,
                                userLayoutController
                                    .studentLocation.homeLongitude!,
                              ),
                            ),
                          ),
                        if (userLayoutController
                                .studentLocation.universityName !=
                            null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: userLayoutController
                                          .studentLocation.homeAddress !=
                                      null
                                  ? 9.0
                                  : 18.0,
                              horizontal: 16.0,
                            ),
                            child: LocationCardWidget(
                              title: "University",
                              address: userLayoutController
                                  .studentLocation.universityName!,
                              latLng: LatLng(
                                userLayoutController
                                    .studentLocation.universityLatitude!,
                                userLayoutController
                                    .studentLocation.universityLongitude!,
                              ),
                            ),
                          ),
                      ],
                    );
            })
          ],
        ),
      ),
    );
  }
}
