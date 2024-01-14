import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/user_widgets/bottomNavigationBar.dart';
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
      bottomNavigationBar: const BottomNavigationBarr(
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
                return EditProfile();
              }));
            }),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfileContainer(),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/setting.svg"),
                    Text(
                      "Settings".tr,
                      style: AppFonts.medium
                          .copyWith(color: AppColors.darkBlue400),
                    ),
                  ],
                ),
              ),
              SettingsCard(),
              LogOut()
            ],
          ),
        ),
      ]),
    );
  }
}
