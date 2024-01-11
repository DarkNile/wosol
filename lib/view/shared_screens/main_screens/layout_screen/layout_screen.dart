import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/Profile_card.dart';
import 'package:wosol/shared/widgets/shared_widgets/settingsCard.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SettingsCard(
            isSwitcher: true,
            title: 'ccc',
          ),
         ProfileCard(title: "Location", 
         leadingImagePath: "assets/images/routing.png")
        ],
      ),
    ));
  }
}
