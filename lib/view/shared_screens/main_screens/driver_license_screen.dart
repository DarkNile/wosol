import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';

import '../../../shared/widgets/shared_widgets/custom_header.dart';

class DriverLicenseScreen extends StatelessWidget {
  const DriverLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomHeaderWithBackButton(header: "license".tr),
            Image.network(
              AppConstants.userRepository.driverData.drivingLicence,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return child;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
