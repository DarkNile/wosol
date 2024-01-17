import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/profile_container.dart';
import 'package:wosol/shared/widgets/shared_widgets/settingsCard.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const ProfileCard(),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/setting.svg"),
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
              const SizedBox(
                height: 24,
              ),
              DefaultRowButton(
                function: () {
                  Get.offAll(() => const LoginScreen());
                },
                text: "Logout".tr,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textColor: AppColors.error600,
                containIcon: true,
                svgPic: "assets/icons/logout.svg",
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
