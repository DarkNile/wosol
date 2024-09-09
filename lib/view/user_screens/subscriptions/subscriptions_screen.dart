import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/user_widgets/subscriptions_widget.dart';
import 'package:get/get.dart';

import '../../../controllers/shared_controllers/profile_controller.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key, required this.profileController});

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
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
                      if (profileController.currentSubscription != null)
                        SubscriptionsWidget(
                          subscriptionModel:
                              profileController.currentSubscription!,
                        ),
                      if (profileController.previousSubscriptions.isNotEmpty)
                        const SizedBox(
                          height: 24,
                        ),
                      if (profileController.previousSubscriptions.isNotEmpty)
                        Text(
                          "previous".tr,
                          style: AppFonts.header,
                        ),
                      ...List.generate(
                          profileController.previousSubscriptions.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SubscriptionsWidget(
                                  subscriptionModel: profileController
                                      .previousSubscriptions[index],
                                ),
                              ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customDivider() {
  return const SizedBox(
    height: 10,
  );
}
