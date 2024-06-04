import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/shared_controllers/profile_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
    required this.profileController,
  });

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomHeaderWithBackButton(
              header: "Terms & Conditions".tr,
              onBackPressed: () {
                Navigator.pop(context, true);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Text(
                    profileController.terms,
                    textAlign: TextAlign.justify,
                    style: AppFonts.button.copyWith(
                      color: AppColors.black,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
