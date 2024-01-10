import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_map_iamge_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_arrow_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_dot_widget.dart';

class CustomRouteCardWidget extends StatelessWidget {
  const CustomRouteCardWidget({super.key});

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
              const CustomRowWithArrowWidget(
                  from: 'Mecca Center', to: ' King Abdelaziz University'),
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
                from: 'View on map',
                isButton: true,
                onTapButton: () {},
                to: '',
              )
            ],
          ),
        ));
  }
}
