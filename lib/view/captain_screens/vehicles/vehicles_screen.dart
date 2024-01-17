import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/captain_widgets/vehicles_card_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomHeaderWithBackButton(header: "Vehicles".tr),
            Expanded(
              child: ListView.separated(
                  physics: const PageScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 18),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return VehiclesCardWidget(
                      carType: 'White Toyota Hiace 2023',
                      seats: '28 ${"seats".tr}',
                      carNumberImage: 'assets/images/car_number.png',
                      carImage: 'assets/images/car.png',
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
