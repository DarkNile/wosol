import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/loginButton.dart';
import 'package:wosol/view/captain_screens/bottom_nav_bar_captain.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/logOut.dart';
import 'package:wosol/shared/widgets/shared_widgets/profile_container.dart';
import 'package:wosol/shared/widgets/shared_widgets/settingsCard.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarCaptain(
        index: 3,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(children: [
        CustomHeader(
            header: "Farah",
            svgIcon: 'assets/icons/logo.svg',
            iconWidth: 40,
            iconHeight: 40,
            isHome: true,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const EditProfile();
              }));
            }),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const ProfileCard(),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/setting.svg"),
                    // Todo : missing sized box check figma please 😅
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
              LogOut(),
            ],
          ),
        ),
      ]),
    );
  }
}
