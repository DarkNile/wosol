import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/bottom_sheets.dart';
import 'package:wosol/shared/widgets/shared_widgets/notification_ListView.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';
import 'package:wosol/view/shared_screens/auth/settings_screen.dart';
import 'package:wosol/view/user_screens/vehicles_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: VehiclesScreen(),
      ),
    );
  }
}
