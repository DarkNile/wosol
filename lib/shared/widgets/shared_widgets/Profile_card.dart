import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.title,
      this.subTitle,
      required this.leadingImagePath,
      this.trailingWidget});
  final String title;
  final String? subTitle;
  final Widget? trailingWidget;
  final String leadingImagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppConstants.edge(padding: const EdgeInsets.all(10)),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.asset(leadingImagePath),
        title: Text(title),
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
