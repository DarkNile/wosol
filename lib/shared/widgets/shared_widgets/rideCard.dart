import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

class RideCard extends StatelessWidget {
  const RideCard(
      {super.key,
      required this.title,
      required this.date,
      required this.imgPath});
  final String title;
  final String imgPath;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.screenHeight(context) * .02),
      child: Container(
        padding: AppConstants.edge(padding: const EdgeInsets.all(6)),
        decoration: BoxDecoration(
            color: AppColors.logo, borderRadius: BorderRadius.circular(12)),
        width: AppConstants.screenWidth(context),
        height: AppConstants.screenHeight(context) * .155,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From $title Within $date mins",
                    // title + date,
                    softWrap: true,
                    style: AppFonts.header.copyWith(color: Colors.white),
                  ),
                  Row(
                    children: [
                      DefaultTextButton(
                        function: () {},
                        text: 'Ride Details',
                        textColor: Colors.white,
                        fontSize: 18,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 3, child: SvgPicture.asset(imgPath))
        ]),
      ),
    );
  }
}
