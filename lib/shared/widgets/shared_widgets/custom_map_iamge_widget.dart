import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';

class CustomMapImageWidget extends StatelessWidget {
  final String image;
  const CustomMapImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103,
      width: AppConstants.screenWidth(context),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage(image))),
    );
  }
}
