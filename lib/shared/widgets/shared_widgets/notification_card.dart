import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/notification_menu_widget.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key,
      required this.notificationTitle,
      required this.notificationTime,
      this.isHover,
      required this.color,
      required this.onSelected});
  final String notificationTitle;
  final String notificationTime;
  final Color color;
  final bool? isHover;

  final void Function(String)? onSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87 + 3,
      color: color,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: SizedBox(
                        width: AppConstants.screenWidth(context) <= 353
                            ? AppConstants.screenWidth(context) * .64
                            : AppConstants.screenWidth(context) * .68,
                        child: Text(
                          notificationTitle,
                          style: const TextStyle(
                            color: AppColors.black,
                            textBaseline: TextBaseline.ideographic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                NotificationMenuWidget(
                  onSelected: onSelected,
                ),
              ]),
        ],
      ),
    );
  }
}
