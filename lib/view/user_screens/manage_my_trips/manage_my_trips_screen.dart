import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/user_controllers/manage_trips_controller.dart';
import 'package:wosol/models/manage_trips_model.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/info_card.dart';
import 'package:wosol/shared/widgets/user_widgets/custom_user_manage_card.dart';
import 'package:wosol/shared/widgets/user_widgets/manage_my_trips_header_widget.dart';

class ManageMyTripUsersScreen extends StatefulWidget {
  const ManageMyTripUsersScreen({super.key});

  @override
  State<ManageMyTripUsersScreen> createState() =>
      _ManageMyTripUsersScreenState();
}

class _ManageMyTripUsersScreenState extends State<ManageMyTripUsersScreen>
    with TickerProviderStateMixin {
  final UserManageTripsController userManageTripsController =
      Get.put<UserManageTripsController>(UserManageTripsController());
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  RxInt selectIndex = RxInt(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ManageMyTripsHeaderWidget(
            controller: tabController,
            selectIndex: selectIndex.value,
            onTap: (index) {
              selectIndex.value = index;
              tabController.animateTo(index);
            },
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: [
              AllWidget(userManageTripsController: userManageTripsController),
              AllWidget(userManageTripsController: userManageTripsController),
              AllWidget(userManageTripsController: userManageTripsController),
              AllWidget(userManageTripsController: userManageTripsController),
              AllWidget(userManageTripsController: userManageTripsController),
            ],
          ))
        ]),
      ),
    );
  }
}

class AllWidget extends StatelessWidget {
  const AllWidget({
    super.key,
    required this.userManageTripsController,
  });

  final UserManageTripsController userManageTripsController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...List.generate(
                3,
                (index) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('saturday'.tr,
                            style: AppFonts.header
                                .copyWith(color: AppColors.black800)),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomUserManageCardWidget(
                          manageTrips: ManageTripsModel(
                            from: "King Abdelaziz University",
                            isToggleOn: false.obs,
                            time: "10:00",
                            to: "Home".tr,
                          ),
                          userManageTripsController: userManageTripsController,
                          hasHint: index == 1 ? true : false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomUserManageCardWidget(
                          manageTrips: ManageTripsModel(
                            from: "King Abdelaziz University",
                            isToggleOn: false.obs,
                            time: "10:00",
                            to: "Home".tr,
                          ),
                          userManageTripsController: userManageTripsController,
                          hasButton: index == 1 ? true : false,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    )),
            const InfoCard(),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
