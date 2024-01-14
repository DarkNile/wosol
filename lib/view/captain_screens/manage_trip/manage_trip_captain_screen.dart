import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/captain_widgets/user_list_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

class ManageTripCaptainScreen extends StatelessWidget {
  const ManageTripCaptainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeader(
          header: "manageTrip".tr,
          svgIcon: 'assets/icons/close_header.svg',
          iconWidth: 24,
          iconHeight: 24,
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
                    child: UserListWidget(length: index == 1 ? 1 : 3),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: 3),
        )
      ],
    );
  }
}
