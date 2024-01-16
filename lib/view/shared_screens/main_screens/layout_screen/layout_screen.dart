import 'package:flutter/material.dart';
import 'package:wosol/controllers/captain_controllers/driver_layout_controller.dart';
import 'package:wosol/shared/widgets/shared_widgets/settingsCard.dart';
import 'package:wosol/view/captain_screens/bottom_nav_bar_captain.dart';
import 'package:wosol/view/captain_screens/vehicles/vehicles_screen.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';
import 'package:wosol/view/shared_screens/auth/settings_screen.dart';
import 'package:wosol/view/shared_screens/notification_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBarCaptain(
          driverLayoutController: DriverLayoutController()),
      body: const SafeArea(child: EditProfile()),
    );
  }
}
