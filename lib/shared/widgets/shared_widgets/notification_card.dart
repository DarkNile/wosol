import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
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
                          // Todo : Replace Text.rich with Row to fix overflow check figma text style

                          Row(children: [
                            Text(
                              "You canceled your trip ",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.orange,
                                textBaseline: TextBaseline.ideographic,
                              ),
                            ),
                            Text(
                              notificationTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.black,
                                textBaseline: TextBaseline.ideographic,
                              ),
                            ),
                          ]),

                          Text(notificationTime,
                              softWrap: true,
                              style:
                                  // Todo use Appfonts with copyWith
                                  AppFonts.style12Urb),
                        ],
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/icons/list_mobile.svg',
                  height: 24,
                  width: 24,
                ),
                // const Icon(
                //   Icons.more_vert,
                //   size: 30,
                //   color: AppColors.darkBlue300,
                // ),
              ]),
        ],
      ),
    );
  }
}
