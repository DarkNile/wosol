import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/Profile_card.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ProfileCard(
            title: "Farah",
            leadingImagePath: "assets/images/avatar.png",
            subTitle: '0100000',
            borderRadius: 8,
            trailingWidget: DefaultButton(
              function: () {},
              text: "Edit",
              textColor: AppColors.btnTxtColor,
              color: AppColors.btnBgColor,
              width: AppConstants.screenWidth(context) * .2,
              height: AppConstants.screenHeight(context) * .1 - 40,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileCard(
                title: "Vehicles",
                leadingImagePath: "assets/images/bus.png",
                subTitle: "Toyota Hiace, Toyota Coaster, .. etc",
              ),
              SizedBox(
                height: 1,
              ),
              ProfileCard(
                title: "Routes",
                leadingImagePath: "assets/images/routing.png",
                subTitle: "Mecca, Jedaha  ",
              ),
              SizedBox(
                height: 1,
              ),
              ProfileCard(
                title: "License ",
                leadingImagePath: "assets/images/personalcard.png",
                subTitle: "Tdriving license, car license",
              )
            ],
          ),
        ],
      ),
    );
  }
}
