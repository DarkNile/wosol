import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/location_card_widget.dart';

class UserLocationsScreen extends StatelessWidget {
  const UserLocationsScreen({super.key});

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
              header: "locations".tr,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  top: 18,
                  left: 16,
                  right: 16,
                ),
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) => const LocationCardWidget(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
