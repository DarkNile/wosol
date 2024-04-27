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
import 'package:wosol/view/user_screens/locations/user_locations_screen.dart';
import 'package:wosol/view/user_screens/subscriptions/subscriptions_screen.dart';
import 'package:wosol/view/user_screens/trips/user_trips_screen.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key, required this.userImage, required this.profileController});

  final String userImage;
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
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
        subTitle: "monthly".tr,
        onTap: () {
          Get.to(() => const SubscriptionsScreen());
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
    ];
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
        onTap: () {},
      ),
    ];
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
                    return EditProfile(profileController: profileController,);
                  }));
                },
                title: AppConstants.isCaptain
                    ? "${AppConstants.userRepository.driverData
                    .firstName} ${AppConstants.userRepository.driverData
                    .lastName}"
                    : "${AppConstants.userRepository.userData
                    .userFname} ${AppConstants.userRepository.userData
                    .userLname}",
                subTitle: AppConstants.isCaptain
                    ? AppConstants.userRepository.driverData.userEmail
                    : AppConstants.userRepository.userData.userEmail,
                isProfile: true,
              );
            }),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            height: 195,
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
              itemCount: AppConstants.isCaptain
                  ? captainProfileItems.length
                  : userProfileItems.length,
              itemBuilder: (context, index) {
                return CustomProfileRowWidget(
                  image: AppConstants.isCaptain
                      ? captainProfileItems[index].imagePath
                      : userProfileItems[index].imagePath,
                  title: AppConstants.isCaptain
                      ? captainProfileItems[index].title
                      : userProfileItems[index].title,
                  subTitle: AppConstants.isCaptain
                      ? captainProfileItems[index].subTitle
                      : userProfileItems[index].subTitle,
                  onTap: AppConstants.isCaptain
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
