import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class VehiclesCardWidget extends StatelessWidget {
  final String carType;
  final String carNumberImage;
  final String carImage;
  final String seats;
  final String carPlateNumber;
  const VehiclesCardWidget({
    super.key,
    required this.carType,
    required this.seats,
    required this.carNumberImage,
    required this.carImage,
    required this.carPlateNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 147 + 3,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.darkBlue100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  carType,
                  style: AppFonts.medium.copyWith(
                    fontSize: 14.0.sp(context),
                    color: AppColors.black800,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/seats.svg',
                  width: 14,
                  height: 14,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  seats,
                  style: AppFonts.medium.copyWith(
                    fontSize: 12.0.sp(context),
                    color: AppColors.logo,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
          const SizedBox(
            height: 12,
          ),

          const Divider(
            height: 1,
            color: AppColors.darkBlue100,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  carImage,
                  width: 100,
                  height: 72,
                ),
                Column(
                  children: [
                    Text(carPlateNumber,
                    style: AppFonts.medium,
                    ),
                    Image.asset(
                      carNumberImage,
                      width: 84,
                      height: 46,
                    ),
                  ],
                ),
              ]),
        ],
      ),
    );
  }
}
