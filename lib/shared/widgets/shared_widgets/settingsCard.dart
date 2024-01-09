import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.screenHeight(context) * .1 - 20,
      margin: AppConstants.edge(padding: const EdgeInsets.all(2)),
      padding: AppConstants.edge(padding: const EdgeInsets.all(10)),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Notifications",
            style: AppFonts.header,
          ),
          const Icon(
            Icons.arrow_forward,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}