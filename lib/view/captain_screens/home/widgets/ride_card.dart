import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

class RideCard extends StatelessWidget {
  const RideCard({
    super.key,
    required this.title,
    required this.time,
    required this.imgPath,
    this.isNextRide = false,
    required this.onTap,
  });
  final void Function() onTap;
  final String title;
  final String imgPath;
  final String time;
  final bool isNextRide;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: AppConstants.edge(
        padding: EdgeInsets.only(
          top: 18,
          left: 18,
          right: isNextRide ? 15 : 18,
          bottom: 18,
        ),
      ),
      decoration: BoxDecoration(
        color: isNextRide ? AppColors.logo : AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: AppConstants.screenWidth(context),
      height: 122,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "From $title\n${isNextRide ? "Within $time" : "at $time"}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: AppFonts.header.copyWith(
                    fontSize: isNextRide ? 18 : 14,
                    color: isNextRide ? AppColors.white : AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    DefaultTextButton(
                      function: onTap,
                      text: "",
                      textAsWidget: Row(
                        children: [
                          Text(
                            'Ride Details',
                            style: AppFonts.small.copyWith(
                              fontSize: 14,
                              color: isNextRide
                                  ? AppColors.white
                                  : AppColors.darkBlue500Base,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            CupertinoIcons.arrow_right,
                            size: 18,
                            color: isNextRide
                                ? AppColors.white
                                : AppColors.darkBlue500Base,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SvgPicture.asset(imgPath),
        ],
      ),
    );
  }
}
