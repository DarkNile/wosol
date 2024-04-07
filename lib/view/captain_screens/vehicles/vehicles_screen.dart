import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/captain_controllers/vehicle_controller.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/captain_widgets/vehicles_card_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

class VehiclesScreen extends StatelessWidget {
  VehiclesScreen({super.key});

  final VehicleController vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    vehicleController.getDriverVehicles();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomHeaderWithBackButton(header: "Vehicles".tr),
            Obx(
              () {
                if (vehicleController.isGettingVehicles.value) {
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: Get.height / 3),
                        child: const CircularProgressIndicator()),
                  );
                }
                return vehicleController.vehiclesList.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height / 3),
                          child: Text(
                            "No Vehicles".tr,
                            style: AppFonts.header,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                            physics: const PageScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 18),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            shrinkWrap: true,
                            itemCount: vehicleController.vehiclesList.length,
                            itemBuilder: (context, index) {
                              return VehiclesCardWidget(
                                carType: vehicleController
                                        .vehiclesList[index].model ??
                                    "",
                                seats:
                                    '${vehicleController.vehiclesList[index].seats} ${"seats".tr}',
                                carPlateNumber: vehicleController.vehiclesList[index].plateNumber.toString(),
                                carNumberImage: 'assets/images/car_number.png',
                                carImage: 'assets/images/car.png',
                              );
                            }),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
