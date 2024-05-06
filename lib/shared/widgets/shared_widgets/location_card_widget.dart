import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_map_iamge_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_arrow_widget.dart';
import 'package:wosol/view/captain_screens/routes/map_screen.dart';

class LocationCardWidget extends StatelessWidget {
  const LocationCardWidget({
    super.key,
    required this.title,
    required this.address, required this.latLng,
  });

  final String title;
  final String address;
  final LatLng latLng;

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
              Text(title,
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
                        address,
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
                  onTapButton: () {
                    Get.to(()=> MapRoutesScreen(
                      fromLatLng:latLng ,
                    ));
                  })
            ],
          ),
        ));
  }
}
