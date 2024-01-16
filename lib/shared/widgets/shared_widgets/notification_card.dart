import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key,
      required this.notificationTitle,
      required this.notificationTime,
      this.isHover,
      required this.color});
  final String notificationTitle;
  final String notificationTime;
  final Color color;
  final bool? isHover;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      color: color,
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
                          SizedBox(
                            width: 262,
                            child: Text.rich(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'You canceled ',
                                    style: TextStyle(
                                      color: AppColors.orange,
                                      textBaseline: TextBaseline.ideographic,
                                    ),
                                  ),
                                  TextSpan(
                                    text: notificationTitle,
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      textBaseline: TextBaseline.ideographic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
              ]),
        ],
      ),
    );
  }
}
