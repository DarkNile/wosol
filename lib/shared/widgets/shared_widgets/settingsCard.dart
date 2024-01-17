import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/shared_controllers/main_controllers/localization_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_setting_row.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController =
        LocalizationController();
    return Container(
        height: 208,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            CustomSettingRowWidget(
              isSwitcher: true,
              title: 'Notifications'.tr,
            ),
            const Divider(
              height: 1,
              color: AppColors.darkBlue100,
            ),
            CustomSettingRowWidget(
              isSwitcher: true,
              title: 'Login with finger print'.tr,
            ),
            const Divider(
              height: 1,
              color: AppColors.darkBlue100,
            ),
            CustomSettingRowWidget(
              isSwitcher: false,
              title: 'Terms & Conditions'.tr,
            ),
            const Divider(
              height: 1,
              color: AppColors.darkBlue100,
            ),
            CustomSettingRowWidget(
              onTapChangeLanguage: () async {
                AppConstants.isEnLocale
                    ? await localizationController
                        .changeLocale(const Locale("ar"))
                    : await localizationController
                        .changeLocale(const Locale("en"));
              },
              isSwitcher: false,
              lang: true,
              title: 'Change Language',
            ),
          ],
        ));
  }
}
