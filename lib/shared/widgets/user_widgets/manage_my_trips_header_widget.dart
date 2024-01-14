import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/user_widgets/user_trips_tab_bar.dart';

class ManageMyTripsHeaderWidget extends StatelessWidget {
  const ManageMyTripsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 1,
        child: Container(
          height: 112,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).copyWith(top: 10, bottom: 10),
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomHeader(
                elevation: 0,
                height: 36,
                hasPadding: false,
                header: 'manageMyTrips'.tr,
                svgIcon: 'assets/icons/call.svg',
                iconWidth: 36,
                iconHeight: 36,
              ),
              const SizedBox(
                height: 20,
              ),
              const UserTripsTabBarWidget(),
            ],
          ),
        ));
  }
}
