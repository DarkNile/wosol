import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/shared_controllers/profile_controller.dart';
import 'package:wosol/models/profile_custom_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_profile_row.dart';
import 'package:wosol/view/captain_screens/routes/routes_screen.dart';
import 'package:wosol/view/captain_screens/vehicles/vehicles_screen.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';
import 'package:wosol/view/shared_screens/main_screens/driver_license_screen.dart';
import 'package:wosol/view/user_screens/attendance/user_attendance_screen.dart';
import 'package:wosol/view/user_screens/locations/user_locations_screen.dart';
import 'package:wosol/view/user_screens/subscriptions/subscriptions_screen.dart';
import 'package:wosol/view/user_screens/trips/user_trips_screen.dart';
import 'package:wosol/view/user_screens/trips_change_days/user_trips_change_days_screen.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key, required this.userImage, required this.profileController});

  final String userImage;
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    //
    List<ProfileCustomModel> userProfileItems = [
      ProfileCustomModel(
        imagePath: "assets/icons/location.svg",
        title: "location".tr,
        subTitle: "homeUniversity".tr,
        onTap: () {
          Get.to(() => const UserLocationsScreen());
        },
      ),
      ProfileCustomModel(
        imagePath: "assets/icons/receipt.svg",
        title: "subscriptions".tr,
        subTitle: getSubscriptionType(
            profileController.currentSubscription?.startDate ?? "",
            profileController.currentSubscription?.endDate ?? ""),
        onTap: () async {
          Get.to(() => SubscriptionsScreen(
                profileController: profileController,
              ));
        },
      ),
      ProfileCustomModel(
        imagePath: "assets/icons/NA-note.svg",
        title: "attendance".tr,
        subTitle: "Your Attendance".tr,
        onTap: () {
          Get.to(() => UserAttendanceScreen());
        },
      ),
      ProfileCustomModel(
        imagePath: "assets/icons/routing.svg",
        title: "myRoutes".tr,
        subTitle: "startReturn".tr,
        onTap: () {
          Get.to(() => const UserTripsScreen());
        },
      ),
      ProfileCustomModel(
        imagePath: "assets/icons/NA-note.svg",
        title: "myCalendar".tr,
        subTitle: "requestChangeDays".tr,
        onTap: () {
          Get.to(() => const UserTripsChangeDaysScreen());
        },
      ),
    ];
    //
    List<ProfileCustomModel> captainProfileItems = [
      ProfileCustomModel(
        imagePath: "assets/icons/bus.svg",
        title: "vehicles".tr,
        subTitle: "Toyota Hiace, Toyota Coaster, .. etc",
        onTap: () {
          Get.to(() => VehiclesScreen());
        },
      ),
      ProfileCustomModel(
        imagePath: "assets/icons/routing.svg",
        title: "routes".tr,
        subTitle: "Mecca, Jedaha  ",
        onTap: () {
          Get.to(() => const CaptainRoutesScreen());
        },
      ),
      ProfileCustomModel(
        imagePath: "assets/icons/personalcard.svg",
        title: "license".tr,
        subTitle: "drivingAndCarLicense".tr,
        onTap: () {
          Get.to(() => const DriverLicenseScreen());
        },
      ),
    ];
    //
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          Container(
            height: 67,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: GetBuilder<ProfileController>(builder: (logic) {
              return CustomProfileRowWidget(
                image: userImage,
                onTapEdit: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditProfile(
                      profileController: profileController,
                    );
                  }));
                },
                title: AppConstants.userType == 'Driver'
                    ? "${AppConstants.userRepository.driverData.firstName} ${AppConstants.userRepository.driverData.lastName}"
                    : AppConstants.userType == 'Employee'
                        ? "${AppConstants.userRepository.employeeData.firstName} ${AppConstants.userRepository.employeeData.lastName}"
                        : "${AppConstants.userRepository.userData.userFname} ${AppConstants.userRepository.userData.userLname}",
                subTitle: AppConstants.userType == 'Driver'
                    ? AppConstants.userRepository.driverData.userEmail
                    : AppConstants.userType == 'Employee'
                        ? AppConstants.userRepository.employeeData.userEmail
                        : AppConstants.userRepository.userData.userEmail,
                isProfile: true,
              );
            }),
          ),
          if (AppConstants.userType != 'Employee')
            const SizedBox(
              height: 24,
            ),
          if (AppConstants.userType != 'Employee')
            Container(
              height: AppConstants.userType == 'Driver'
                  ? 195
                  :
                  // old  260,
                  330,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    color: AppColors.darkBlue100,
                  );
                },
                itemCount: AppConstants.userType == 'Driver'
                    ? captainProfileItems.length
                    : userProfileItems.length,
                itemBuilder: (context, index) {
                  return CustomProfileRowWidget(
                    image: AppConstants.userType == 'Driver'
                        ? captainProfileItems[index].imagePath
                        : userProfileItems[index].imagePath,
                    title: AppConstants.userType == 'Driver'
                        ? captainProfileItems[index].title
                        : userProfileItems[index].title,
                    subTitle: AppConstants.userType == 'Driver'
                        ? captainProfileItems[index].subTitle
                        : userProfileItems[index].subTitle,
                    onTap: AppConstants.userType == 'Driver'
                        ? captainProfileItems[index].onTap
                        : userProfileItems[index].onTap,
                    isProfile: false,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

String getSubscriptionType(String startDate, String endDate) {
  // Parse the dates from strings to DateTime objects
  final DateTime? start = DateTime.tryParse(startDate);
  final DateTime? end = DateTime.tryParse(endDate);

  // Calculate the duration in days
  if (start != null && end != null) {
    final int durationInDays = end.difference(start).inDays;
    if (durationInDays >= 365) {
      return 'Yearly'.tr;
    } else if (durationInDays >= 28 && durationInDays <= 31) {
      return 'monthly'.tr;
    }
  } else {
    return '';
  }
  return '';
}
