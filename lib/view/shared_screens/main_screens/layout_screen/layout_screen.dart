import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/Profile_card.dart';
import 'package:wosol/shared/widgets/shared_widgets/profile_container.dart';
import 'package:wosol/shared/widgets/shared_widgets/settingsCard.dart';
import 'package:wosol/shared/widgets/shared_widgets/settings_container.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [ProfileContainer(),SettingsContainer()],
          ),
        ),
      ),
    );
  }
}
