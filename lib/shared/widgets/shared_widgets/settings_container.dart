import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/settingsCard.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SettingsCard(isSwitcher: true, title: "Notifications"),
          SettingsCard(isSwitcher: true, title: "Login with finger print"),
          SettingsCard(isSwitcher: false, title: "Terms & Conditions"),
          SettingsCard(
            isSwitcher: false,
            title: "Change",
            lang: true,
          )
        ],
      ),
    );
  }
}
