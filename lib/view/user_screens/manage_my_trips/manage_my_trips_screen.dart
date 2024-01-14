import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/info_card.dart';
import 'package:wosol/shared/widgets/user_widgets/custom_user_manage_card.dart';
import 'package:wosol/shared/widgets/user_widgets/manage_my_trips_header_widget.dart';

class ManageMyTripUsersScreen extends StatelessWidget {
  const ManageMyTripUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const ManageMyTripsHeaderWidget(),
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                    3,
                    (index) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Saturday',
                                style: AppFonts.header
                                    .copyWith(color: AppColors.black800)),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomUserManageCardWidget(
                              hasHint: index == 1 ? true : false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomUserManageCardWidget(
                              hasButton: index == 1 ? true : false,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        )),
                const InfoCard(),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
