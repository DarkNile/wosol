import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_profile_row.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          Container(
            height: 67,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomProfileRowWidget(
              image: '',
              onTapEdit: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const EditProfile();
                }));
              },
              title: 'Hossam Essam',
              subTitle: '+966 123 456 7890',
              isProfile: true,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            height: 195,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomProfileRowWidget(
                  image: "assets/images/bus.png",
                  title: "Vehicles".tr,
                  subTitle: "Toyota Hiace, Toyota Coaster, .. etc",
                  isProfile: false,
                ),
                const Divider(
                  height: 1,
                  color: AppColors.darkBlue100,
                ),
                CustomProfileRowWidget(
                  image: "assets/images/routing.png",
                  title: "Routes".tr,
                  subTitle: "Mecca, Jedaha  ",
                  isProfile: false,
                ),
                const Divider(
                  height: 1,
                  color: AppColors.darkBlue100,
                ),
                CustomProfileRowWidget(
                  image: "assets/images/personalcard.png",
                  title: "License".tr,
                  subTitle: "Tdriving license, car license",
                  isProfile: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
