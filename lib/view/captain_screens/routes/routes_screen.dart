import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

import '../../../shared/widgets/captain_widgets/custom_route_card_widget.dart';

class CaptainRoutesScreen extends StatelessWidget {
  const CaptainRoutesScreen({super.key});

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
            CustomHeaderWithBackButton(header: "routes".tr),
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  physics: const PageScrollPhysics(),
                  itemBuilder: (context, index) =>
                      const CustomRouteCardWidget(),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: 3),
            )
          ],
        ),
      ),
    );
  }
}
