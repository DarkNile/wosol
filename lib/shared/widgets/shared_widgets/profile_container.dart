import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_profile_row.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

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
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomProfileRowWidget(
              image: '',
              onTapEdit: () {},
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomProfileRowWidget(
                  image: "assets/images/bus.png",
                  title: "Vehicles",
                  subTitle: "Toyota Hiace, Toyota Coaster, .. etc",
                  isProfile: false,
                ),
                Divider(
                  height: 1,
                  color: AppColors.darkBlue100,
                ),
                CustomProfileRowWidget(
                  image: "assets/images/routing.png",
                  title: "Routes",
                  subTitle: "Mecca, Jedaha  ",
                  isProfile: false,
                ),
                Divider(
                  height: 1,
                  color: AppColors.darkBlue100,
                ),
                CustomProfileRowWidget(
                  image: "assets/images/personalcard.png",
                  title: "License ",
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
