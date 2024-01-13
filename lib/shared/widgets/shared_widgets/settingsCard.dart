import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_setting_row.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 208,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(8)),
        child: const Column(
          children: [
            CustomSettingRowWidget(
              isSwitcher: true,
              title: 'Notifications',
            ),
            Divider(
              height: 1,
              color: AppColors.darkBlue100,
            ),
            CustomSettingRowWidget(
              isSwitcher: true,
              title: 'Login with finger print',
            ),
            Divider(
              height: 1,
              color: AppColors.darkBlue100,
            ),
            CustomSettingRowWidget(
              isSwitcher: false,
              title: 'Terms & Conditions',
            ),
            Divider(
              height: 1,
              color: AppColors.darkBlue100,
            ),
            CustomSettingRowWidget(
              isSwitcher: false,
              lang: true,
              title: 'Change Language',
            ),
          ],
        ));
  }
}
