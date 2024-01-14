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
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: AppColors.orange2,
          child: SvgPicture.asset("assets/icons/notification.svg")),
      title: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: "You canceled your trip ",
            style: const TextStyle(
                color: AppColors.orange,
                textBaseline: TextBaseline.ideographic),
          ),
          TextSpan(
            text: notificationTitle,
            style: const TextStyle(textBaseline: TextBaseline.ideographic),
          ),
        ]),
        softWrap: true,
      ),
      subtitle: Text(
        notificationTime,
        style: AppFonts.medium
            .copyWith(color: AppColors.darkBlue300, fontSize: 16),
      ),
      trailing: const Icon(
        Icons.more_vert,
        size: 30,
        color: AppColors.darkBlue300,
      ),
    );
  }
}
