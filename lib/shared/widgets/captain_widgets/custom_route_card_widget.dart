import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_map_iamge_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_arrow_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_dot_widget.dart';
import 'package:wosol/view/captain_screens/routes/map_screen.dart';

import '../../../models/driver_routes.dart';

class CustomRouteCardWidget extends StatelessWidget {
  const CustomRouteCardWidget({
    super.key,
    required this.driverRoute,
  });

  final DriverRoute driverRoute;

  @override
  Widget build(BuildContext context) {
    return CustomContainerCardWithBorderWidget(
        height: 324,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomMapImageWidget(image: 'assets/images/route_map.png'),
              const SizedBox(
                height: 13,
              ),
              CustomRowWithArrowWidget(
                  from: driverRoute.from, to: ' ${driverRoute.to}'),
              const SizedBox(
                height: 11,
              ),
              const CustomRowWithDotWidget(
                  text:
                      'Mecca Center, FR8C+HXF, At Taniem, Makkah 24224, Saudi Arabia'),
              const SizedBox(
                height: 18,
              ),
              const CustomRowWithDotWidget(
                  isGreen: false,
                  text:
                      ' King Abelaziz Usiversity, F6QV+J49, Unnamed Road King Abdulaziz University, Jeddah 21589, Saudi Arabia'),
              const SizedBox(
                height: 11,
              ),
              CustomRowWithArrowWidget(
                from: 'viewOnMap'.tr,
                isButton: true,
                onTapButton: () {
                  Get.to(
                    () => MapRoutesScreen(
                      fromLatLng: LatLng(
                        double.parse(driverRoute.fromLat),
                        double.parse(driverRoute.fromLong),
                      ),
                      toLatLng: LatLng(
                        double.parse(driverRoute.toLat),
                        double.parse(driverRoute.toLong),
                      ),
                    ),
                  );
                },
                to: '',
              )
            ],
          ),
        ));
  }
}
