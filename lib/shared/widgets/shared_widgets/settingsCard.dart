import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/shared_controllers/profile_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_setting_row.dart';
import 'package:wosol/view/shared_screens/auth/change_password.dart';
import 'package:wosol/view/shared_screens/terms_and_conditions.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({
    super.key,
  });

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  final ProfileController profileController =
      Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 155,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            // Obx(() {
            //   return CustomSettingRowWidget(
            //     isSwitcher: true,
            //     toggleIcon: () => profileController.changeNotificationValue(),
            //     isSwitcherOn: profileController.isNotification.value,
            //     title: 'Notifications'.tr,
            //   );
            // }),
            // const Divider(
            //   height: 1,
            //   color: AppColors.darkBlue100,
            // ),
            // Obx(() {
            //   return CustomSettingRowWidget(
            //     isSwitcher: true,
            //     toggleIcon: () => profileController.changeFingerPrintValue(),
            //     isSwitcherOn: profileController.isFingerPrint.value,
            //     title: 'Login with finger print'.tr,
            //   );
            // }),
            const Divider(
              height: 1,
              color: AppColors.darkBlue100,
            ),
            CustomSettingRowWidget(
              isWithTitleOnly: false,
              isSwitcher: false,
              title: 'Terms & Conditions'.tr,
              function: () async {
                await profileController.termsApi();
                Get.to(() =>
                    TermsAndConditions(profileController: profileController));
              },
            ),
            const Divider(
              height: 1,
              color: AppColors.darkBlue100,
            ),
            CustomSettingRowWidget(
              isWithTitleOnly: false,
              isSwitcher: false,
              title: 'change your password'.tr,
              function: () {
                Get.to(() => ChangePasswordScreen(fromProfile: true));
              },
            ),
            const Divider(
              height: 1,
              color: AppColors.darkBlue100,
            ),
            CustomSettingRowWidget(
              isWithTitleOnly: false,
              onTapChangeLanguage: () async {
                AppConstants.isEnLocale
                    ? await AppConstants.localizationController
                        .changeLocale(const Locale("ar"))
                    : await AppConstants.localizationController
                        .changeLocale(const Locale("en"));
              },
              isSwitcher: false,
              lang: true,
              isWithArrow: false,
              title: 'changeLanguage'.tr,
            ),
          ],
        ));
  }
}
