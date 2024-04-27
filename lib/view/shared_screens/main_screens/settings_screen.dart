import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/services/local/cache_helper.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/profile_container.dart';
import 'package:wosol/shared/widgets/shared_widgets/settingsCard.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';

import '../../../controllers/shared_controllers/profile_controller.dart';
import '../../../shared/constants/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ProfileController profileController =
      Get.put<ProfileController>(ProfileController());
  String userImage = (AppConstants.isCaptain
              ? AppConstants.userRepository.driverData.userImage
              : AppConstants.userRepository.userData.userImage)
          .isNotEmpty
      ? (AppConstants.isCaptain
          ? AppConstants.userRepository.driverData.userImage
          : AppConstants.userRepository.userData.userImage)
      : 'assets/images/user.png';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeader(
              header: AppConstants.isCaptain
                  ? AppConstants.userRepository.driverData.firstName
                  : AppConstants.userRepository.userData.userFname,
              svgIcon: 'assets/icons/logo.svg',
              iconWidth: 40,
              iconHeight: 40,
              isHome: true,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return EditProfile(
                        profileController: profileController,
                      );
                    },
                  ),
                );
              }),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                GetBuilder<ProfileController>(
                    id: "imageUpdated",
                    builder: (logic) {
                      print("iage updated");
                      userImage = (AppConstants.isCaptain
                                  ? AppConstants
                                      .userRepository.driverData.userImage
                                  : AppConstants
                                      .userRepository.userData.userImage)
                              .isNotEmpty
                          ? (AppConstants.isCaptain
                              ? AppConstants.userRepository.driverData.userImage
                              : AppConstants.userRepository.userData.userImage)
                          : 'assets/images/user.png';
                      return ProfileCard(
                        profileController: profileController,
                        userImage: userImage,
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/setting.svg"),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Settings".tr,
                        style: AppFonts.medium
                            .copyWith(color: AppColors.darkBlue400),
                      ),
                    ],
                  ),
                ),
                const SettingsCard(),
                const SizedBox(
                  height: 24,
                ),
                DefaultRowButton(
                  function: () async {
                    await CacheHelper.clearAll();
                    Get.offAll(() => LoginScreen());
                  },
                  text: "Logout".tr,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.error600,
                  containIcon: true,
                  svgPic: "assets/icons/logout.svg",
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
