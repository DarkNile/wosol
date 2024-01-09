import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

class TripHistoryCard extends StatelessWidget {
  const TripHistoryCard(
      {super.key,
      required this.date,
      required this.fromCity,
      required this.toCity});
  final String date;

  final String fromCity;
  final String toCity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.screenHeight(context) * .01),
      child: Container(
        height: AppConstants.screenHeight(context) * .28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: AppConstants.edge(padding: EdgeInsets.all(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Row(
                children: [
                  Text(
                    fromCity,
                    style: AppFonts.header,
                  ),
                  const Icon(Icons.arrow_forward),
                  Text(
                    toCity,
                    style: AppFonts.header,
                  )
                ],
              ),
              Text(
                date,
                style: AppFonts.medium.copyWith(color: AppColors.darkGreyHint),
              ),
              Row(
                children: [
                  DefaultTextButton(
                    function: () {},
                    text: 'Ride Details',
                    textColor: AppColors.darkGreyHint,
                    textStyle:
                        AppFonts.medium.copyWith(color: AppColors.darkGreyHint),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.darkGreyHint,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
