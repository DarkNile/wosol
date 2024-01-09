import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class TripDetailsCard extends StatelessWidget {
  const TripDetailsCard(
      {super.key,
      required this.date,
      required this.fromCity,
      required this.toCity});
  final String date;
  final String fromCity;

  final String toCity;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.screenHeight(context) * .45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: AppConstants.edge(padding: EdgeInsets.all(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/mapp.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Student Trip",
                    style: AppFonts.header.copyWith(fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    date,
                    style: AppFonts.medium
                        .copyWith(color: AppColors.greyHintColor),
                  ),
                ],
              ),
              SvgPicture.asset(
                "assets/icons/cap.svg",
                height: AppConstants.screenHeight(context) * .1 - 20,
              )
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              const Icon(
                Icons.circle,
                color: Colors.green,
                size: 12,
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  fromCity,
                  softWrap: true,
                ),
              )
            ],
          ),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              const Icon(
                Icons.circle,
                color: Colors.red,
                size: 12,
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  toCity,
                  softWrap: true,
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
