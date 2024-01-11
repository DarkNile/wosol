import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.title,
      this.subTitle,
      this.borderRadius = 0,
      required this.leadingImagePath,
      this.trailingWidget = const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      )});
  final String title;
  final String? subTitle;
  final Widget? trailingWidget;
  final String leadingImagePath;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: ListTile(
        leading: Image.asset(leadingImagePath),
        title: Text(
          title,
          style: AppFonts.header,
        ),
        subtitle: Text(
          subTitle ?? '',
          style: AppFonts.small,
          overflow: TextOverflow.fade,
        ),
        trailing: trailingWidget,
      ),
    );
  }
}
