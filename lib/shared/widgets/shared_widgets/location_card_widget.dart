import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_map_iamge_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_arrow_widget.dart';

class LocationCardWidget extends StatelessWidget {
  const LocationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerCardWithBorderWidget(
        height: 237,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomMapImageWidget(
                  image: 'assets/images/map_location.png'),
              const SizedBox(
                height: 13,
              ),
              Text('King Abdelaziz University',
                  style: AppFonts.medium.copyWith(
                    color: AppColors.black800,
                  )),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: SvgPicture.asset('assets/icons/location.svg'),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                        'mecca center, FR8C+HXF, At taniem, makkah 24224, Saudi Arabia',
                        style: AppFonts.small.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkBlue300)),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CustomRowWithArrowWidget(
                  from: 'viewOnMap'.tr,
                  to: '',
                  isButton: true,
                  onTapButton: () {})
            ],
          ),
        ));
  }
}
