import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/captain_image_with_cart_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_map_iamge_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_dot_widget.dart';

class TripDetailsCard extends StatelessWidget {
  const TripDetailsCard(
      {super.key,
      required this.date,
      required this.fromCity,
      required this.toCity,
      this.isCaptain = true,
      this.captainName});
  final String date;
  final bool isCaptain;
  final String? captainName;
  final String fromCity;

  final String toCity;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isCaptain ? 356 : 382,
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: isCaptain ? BorderRadius.circular(12) : null,
      ),
      child: Padding(
        padding: AppConstants.edge(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomMapImageWidget(
            image: "assets/images/map_details.png",
          ),
          const SizedBox(
            height: 26,
          ),
          // Captain
          isCaptain
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Student Trip",
                          style: AppFonts.header
                              .copyWith(color: AppColors.black800),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          date,
                          style: AppFonts.medium.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkBlue700),
                        ),
                      ],
                    ),
                    Container(
                      width: 108,
                      height: 54,
                      padding: const EdgeInsets.only(
                          top: 4, left: 43, right: 19, bottom: 4),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset(
                        "assets/icons/cap.svg",
                        width: 46,
                        height: 46,
                      ),
                    )
                  ],
                )
              :
              // User
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trip with",
                          style: AppFonts.header
                              .copyWith(color: AppColors.black800),
                        ),
                        Text(
                          captainName ?? "Captain Name",
                          style: AppFonts.header
                              .copyWith(color: AppColors.black800),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          date,
                          style: AppFonts.medium.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkBlue700),
                        ),
                      ],
                    ),
                    const CaptainImageWithCartWidget(),
                  ],
                ),
          const SizedBox(
            height: 26,
          ),
          const CustomRowWithDotWidget(
            text:
                'Mecca Center, FR8C+HXF, At Taniem, Makkah 24224, Saudi Arabia',
          ),
          const SizedBox(
            height: 26,
          ),
          Expanded(
            child: CustomRowWithDotWidget(
              text: toCity,
              isGreen: false,
            ),
          )
        ]),
      ),
    );
  }
}
