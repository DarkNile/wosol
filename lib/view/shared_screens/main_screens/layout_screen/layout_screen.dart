import 'package:flutter/material.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';
import 'package:wosol/view/shared_screens/auth/settings_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SettingsScreen())));
  }
}
