import 'package:flutter/material.dart';
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
          CustomHeaderWithBackButton(header: "Vehicles"),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(children: [
              VehiclesCardWidget(
                carType: 'White Toyota Hiace 2023',
                seats: '14',
                carNumberImage: 'assets/images/car_number.png',
                carImage: 'assets/images/car.png',
              ),
              VehiclesCardWidget(
                carType: 'White Toyota Hiace 2023',
                seats: '14',
                carNumberImage: 'assets/images/car_number.png',
                carImage: 'assets/images/car_image.png',
              ),
              VehiclesCardWidget(
                carType: 'White Toyota Hiace 2023',
                seats: '14',
                carNumberImage: 'assets/images/car_number.png',
                carImage: 'assets/images/car.png',
              ),
              VehiclesCardWidget(
                carType: 'White Toyota Hiace 2023',
                seats: '14',
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
