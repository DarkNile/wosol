import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/user_widgets/subscriptions_widget.dart';
import 'package:get/get.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeaderWithBackButton(
          header: "subscriptions".tr,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "current".tr,
                    style: AppFonts.header,
                  ),
                  customDivider(),
                  SubscriptionsWidget(),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "previous".tr,
                    style: AppFonts.header,
                  ),
                  ...List.generate(
                      4,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SubscriptionsWidget(),
                          ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget customDivider() {
  return const SizedBox(
    height: 10,
  );
}
