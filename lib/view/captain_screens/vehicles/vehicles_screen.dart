import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/captain_widgets/vehicles_card_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          CustomHeaderWithBackButton(header: "Vehicles".tr),
          const Padding(
            // Todo : Padding From top should be 18 so we have 10 her and and margin: 5 on Card !! it's 15 not 18
            // Todo : Use ListView.separated Instead of Column and margin
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(children: [
              VehiclesCardWidget(
                carType: 'White Toyota Hiace 2023',
                seats: '28 Seats',
                carNumberImage: 'assets/images/car_number.png',
                carImage: 'assets/images/car.png',
              ),
              VehiclesCardWidget(
                carType: 'White Toyota Hiace 2023',
                seats: '28 Seats',
                carNumberImage: 'assets/images/car_number.png',
                carImage: 'assets/images/car_image.png',
              ),
              VehiclesCardWidget(
                carType: 'White Toyota Hiace 2023',
                seats: '28 Seats',
                carNumberImage: 'assets/images/car_number.png',
                carImage: 'assets/images/car.png',
              ),
              VehiclesCardWidget(
                carType: 'White Toyota Hiace 2023',
                seats: '28 Seats',
                carNumberImage: 'assets/images/car_number.png',
                carImage: 'assets/images/car_image.png',
              )
            ]),
          )
        ],
      ),
    );
  }
}
