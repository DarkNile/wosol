import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/captain_widgets/custom_route_card_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/location_card_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/tripDetailsCard.dart';
import 'package:wosol/shared/widgets/shared_widgets/tripHistoryCard.dart';
import 'package:wosol/shared/widgets/shared_widgets/trips_card_widget.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TripHistoryCard(
            //   fromCity: 'Mecca Center',
            //   toCity: ' King Abdelaziz University',
            //   date: 'Dec 22  - 08:10 am',
            // ),
            LocationCardWidget(),
            SizedBox(
              height: 24,
            ),
            TripCardWidget(
              withBorder: false,
              withCancel: true,
            )

            // TripDetailsCard(
            //   date: 'Dec 22  - 08:10 am',
            //   fromCity:
            //       'Mecca Center, FR8C+HXF, At Taniem, Makkah 24224, Saudi Arabia',
            //   toCity:
            //       'King Abelaziz Usiversity, F6QV+J49, Unnamed Road King Abdulaziz University, Jeddah 21589, Saudi Arabia',
            // ),

            // CustomRouteCardWidget()
          ],
        ),
      ),
    );
  }
}
