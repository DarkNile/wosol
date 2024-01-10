import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_map_iamge_widget.dart';
import 'package:wosol/shared/widgets/user_widgets/user_trip_detail_widget.dart';

class TripCardWidget extends StatelessWidget {
  final bool withCancel;
  final bool withBorder;
  const TripCardWidget(
      {super.key, this.withCancel = false, this.withBorder = true});

  @override
  Widget build(BuildContext context) {
    return CustomContainerCardWithBorderWidget(
      height: withCancel ? (295 + 10 + 7) : (236 + 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: [
            const CustomMapImageWidget(image: 'assets/images/map_details.png'),
            const SizedBox(
              height: 17,
            ),
            const Expanded(child: UserTripDetailWidget()),
            if (withCancel)
              withBorder
                  ? DefaultRowButton(
                      height: 42,
                      border: Border.all(
                        color: AppColors.error600,
                      ),
                      color: AppColors.white,
                      function: () {},
                      textColor: AppColors.error600,
                      borderRadius: 8,
                      svgPic: 'assets/icons/close_red.svg',
                    )
                  : DefaultRowButton(
                      height: 42,
                      color: AppColors.error600,
                      function: () {},
                      borderRadius: 8,
                      svgPic: 'assets/icons/close_white.svg',
                    )
          ],
        ),
      ),
    );
  }
}
