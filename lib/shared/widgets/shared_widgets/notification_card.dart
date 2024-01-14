import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class NotificationCard extends StatelessWidget {
  NotificationCard(
      {super.key,
      required this.notificationTitle,
      required this.notificationTime,
      this.isHover});
  final String notificationTitle;
  final String notificationTime;
  final bool? isHover;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 9.0),
                      child: SizedBox(
                        height: 36,
                        width: 36,
                        child: CircleAvatar(
                            backgroundColor: AppColors.orange2,
                            child: SvgPicture.asset(
                              "assets/icons/notification.svg",
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(children: [
                              const TextSpan(
                                text: "You canceled your trip ",
                                style: TextStyle(
                                    color: AppColors.orange,
                                    textBaseline: TextBaseline.ideographic),
                              ),
                              // TextSpan(
                              //   text: notificationTitle,
                              //   style: TextStyle(
                              //       color: AppColors.black,
                              //       textBaseline: TextBaseline.ideographic),
                              // ),
                            ]),
                            softWrap: true,
                          ),
                          Text(notificationTime,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Urbanist',
                                  color: AppColors.darkBlue400)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.more_vert,
                  size: 30,
                  color: AppColors.darkBlue300,
                ),
              ]),
        ],
      ),
    );
  }
}
