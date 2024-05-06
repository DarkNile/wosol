import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

import '../../../controllers/captain_controllers/driver_layout_controller.dart';
import '../../../shared/widgets/captain_widgets/custom_route_card_widget.dart';

class CaptainRoutesScreen extends StatefulWidget {
  const CaptainRoutesScreen({super.key});

  @override
  State<CaptainRoutesScreen> createState() => _CaptainRoutesScreenState();
}

class _CaptainRoutesScreenState extends State<CaptainRoutesScreen> {
  DriverLayoutController controller = Get.find<DriverLayoutController>();

  @override
  void initState() {
    controller.getDriverRoutes();
    super.initState();
  }

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
            Obx(() {
              return controller.isGettingDriverRoutes.value
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 16,
                          ),
                          physics: const PageScrollPhysics(),
                          itemBuilder: (context, index) =>
                               CustomRouteCardWidget(
                                 driverRoute: controller.driverRoutes[index],
                               ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: controller.driverRoutes.length),
                    );
            })
          ],
        ),
      ),
    );
  }
}
