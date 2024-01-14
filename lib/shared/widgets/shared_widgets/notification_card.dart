import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key,
      required this.notificationTitle,
      required this.notificationTime});
  final String notificationTitle;
  final String notificationTime;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: AppColors.orange2,
          child: SvgPicture.asset("assets/icons/notification.svg")),
      title: Padding(
        padding: AppConstants.edge(padding: const EdgeInsets.only(top: 30)),
        child: Text(
          notificationTitle,
          softWrap: true,
          style: const TextStyle(textBaseline: TextBaseline.ideographic),
        ),
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
