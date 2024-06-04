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
import '../../../models/driver_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/constants/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ProfileController profileController =
      Get.put<ProfileController>(ProfileController());
  String userImage = (AppConstants.userType == 'Driver'
              ? AppConstants.userRepository.driverData.userImage
  : AppConstants.userType == 'Employee'
      ? AppConstants.userRepository.employeeData.userImage
              : AppConstants.userRepository.userData.userImage)
          .isNotEmpty
      ? (AppConstants.userType == 'Driver'
          ? AppConstants.userRepository.driverData.userImage :
  AppConstants.userType == 'Employee'
      ? AppConstants.userRepository.employeeData.userImage
          : AppConstants.userRepository.userData.userImage)
      : 'assets/images/user.png';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeader(
              header: AppConstants.userType == 'Driver'
                  ? AppConstants.userRepository.driverData.firstName :
              AppConstants.userType == 'Employee'
                  ? AppConstants.userRepository.employeeData.firstName
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
                      userImage = (AppConstants.userType == 'Driver'
                                  ? AppConstants
                                      .userRepository.driverData.userImage :
                      AppConstants.userType == 'Employee'
                          ? AppConstants
                          .userRepository.employeeData.userImage
                                  : AppConstants
                                      .userRepository.userData.userImage)
                              .isNotEmpty
                          ? (AppConstants.userType == 'Driver'
                              ? AppConstants.userRepository.driverData.userImage :
                      AppConstants.userType == 'Employee'
                          ? AppConstants.userRepository.employeeData.userImage
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
                    AppConstants.userRepository.userData = UserData(
                      userId: '',
                      userType: '',
                      userFname: '',
                      userLname: '',
                      companyName: '',
                      userEmail: '',
                      userPass: '',
                      telephone: '',
                      supervisorId: '',
                      userNationality: '',
                      nationalId: '',
                      gender: '',
                      address: '',
                      userZone: '',
                      userCity: '',
                      userDistrict: '',
                      parentName: '',
                      parentType: '',
                      parntNationalId: '',
                      parentPhone: '',
                      parentEmail: '',
                      dateAdded: '',
                      lastLogin: '',
                      userAgent: '',
                      loginType: '',
                      token: '',
                      userImage: "",
                    );

                    AppConstants.userRepository.driverData = DriverData(
                      driverId: "",
                      firstName: "",
                      lastName: "",
                      telephone: "",
                      userEmail: "",
                      userName: "",
                      password: "",
                      birthDate: "",
                      idNo: "",
                      idEndDate: "",
                      licenseType: "",
                      licenseEndDate: "",
                      licenseCity: "",
                      vehicles: "",
                      active: "",
                      lastLogin: "",
                      userAgent: "",
                      loginType: "",
                      token: "",
                      userImage: "",
                      drivingLicence: '',
                    );

                    AppConstants.userRepository.employeeData = DriverData(
                      driverId: "",
                      firstName: "",
                      lastName: "",
                      telephone: "",
                      userEmail: "",
                      userName: "",
                      password: "",
                      birthDate: "",
                      idNo: "",
                      idEndDate: "",
                      licenseType: "",
                      licenseEndDate: "",
                      licenseCity: "",
                      vehicles: "",
                      active: "",
                      lastLogin: "",
                      userAgent: "",
                      loginType: "",
                      token: "",
                      userImage: "",
                      drivingLicence: '',
                    );

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
