import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/models/manage_trips_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/info_card.dart';
import 'package:wosol/shared/widgets/user_widgets/custom_user_manage_card.dart';
import 'package:wosol/shared/widgets/user_widgets/manage_my_trips_header_widget.dart';

import '../../../controllers/user_controllers/user_home_controller.dart';
import '../../../models/calendar_model.dart';

class ManageMyTripUsersScreen extends StatefulWidget {
  const ManageMyTripUsersScreen({super.key});

  @override
  State<ManageMyTripUsersScreen> createState() =>
      _ManageMyTripUsersScreenState();
}

class _ManageMyTripUsersScreenState extends State<ManageMyTripUsersScreen>
    with TickerProviderStateMixin {
  final UserHomeController userHomeController = Get.find<UserHomeController>();

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
        length: userHomeController.calendarData.length + 1, vsync: this);
    super.initState();
  }

  RxInt selectIndex = RxInt(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => userHomeController.isGettingCalendar.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ManageMyTripsHeaderWidget(
                  availableDays: userHomeController.calendarData
                      .map(
                        (element) => AppConstants.formatDateToWeekday(
                          element.date!,
                          AppConstants.localizationController.currentLocale(),
                        ),
                      )
                      .toList(),
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
                    ...List.generate(
                      userHomeController.calendarData.length + 1,
                      (index) {
                        if (index == 0) {
                          return AllWidget(
                              homeController: userHomeController,
                              calendarData: userHomeController.calendarData);
                        } else {
                          return AllWidget(
                            homeController: userHomeController,
                            calendarData: [
                              userHomeController.calendarData[index - 1]
                            ],
                          );
                        }
                      },
                    ),
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
    required this.calendarData,
    required this.homeController,
  });

  final List<CalendarData> calendarData;
  final UserHomeController homeController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...List.generate(calendarData.length, (index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${
                    AppConstants.formatDateToWeekday(
                      calendarData[index].date!,
                      AppConstants.localizationController.currentLocale(),
                    )
                  } - ${calendarData[index].date!}',
                      style:
                          AppFonts.header.copyWith(color: AppColors.black800)),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomUserManageCardWidget(
                    calenderId: calendarData[index].subData![0].calendarId!,
                    userId: calendarData[index].subData![0].userId!,
                    calenderDate: calendarData[index].subData![0].cancelDate!,
                    isCancel:
                        calendarData[index].subData![0].cancelRequest == '0',
                    manageTrips: ManageTripsModel(
                      from: calendarData[index].subData!.first.from!,
                      isToggleOn:
                          calendarData[index].subData![0].cancelRequest == '0'
                              ? true.obs
                              : false.obs,
                      time: calendarData[index].subData!.first.time!,
                      to: calendarData[index].subData!.first.universityName!,
                    ),
                    // userManageTripsController: userManageTripsController,
                    hasHint: false,
                    userHomeController: homeController,
                  ),
                  if (calendarData[index].subData!.length > 1)
                    const SizedBox(
                      height: 10,
                    ),
                  if (calendarData[index].subData!.length > 1)
                    CustomUserManageCardWidget(
                      calenderId: calendarData[index].subData![1].calendarId!,
                      userId: calendarData[index].subData![1].userId!,
                      calenderDate: calendarData[index].subData![1].cancelDate!,
                      isCancel:
                          calendarData[index].subData![1].cancelRequest == '0',
                      userHomeController: homeController,
                      manageTrips: ManageTripsModel(
                        from: calendarData[index].subData![1].from!,
                        isToggleOn:
                            calendarData[index].subData![1].cancelRequest == '0'
                                ? true.obs
                                : false.obs,
                        time: calendarData[index].subData![1].time!,
                        to: calendarData[index].subData![1].universityName!,
                      ),
                      // userManageTripsController: userManageTripsController,
                      hasHint: false,
                    ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              );
            }),
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

// /// todo This for Turn off Button
//  if(true /*isNotCanceled*/) {
//             await userHomeController.calendarCancelByDateAPI(
//             context: context,
//             userId: '247',
//             date: '2024-02-18',
//             cancel: '1',
//             cancelReason: 'سبب الالغاء',
//           );
//           }else{
//             /// todo not ready from Api
//             await userHomeController.calendarCancelByDateAPI(
//               context: context,
//               userId: '247',
//               date: '2024-02-18',
//               cancel: '0',
//             );
//           }

// /// todo This for Turn Off this week only Button
// if(true /*isNotCanceled*/) {
//   await userHomeController.calendarCancelAPI(
//     context: context,
//     userId: '248',
//     calendarId: '3078',
//     cancel: '1',
//     cancelReason: 'سبب الالغاء',
//   );
// }else{
//   /// todo not ready from Api
//   await userHomeController.calendarCancelAPI(
//     context: context,
//     userId: '248',
//     calendarId: '3078',
//     cancel: '0',
//   );
// }
