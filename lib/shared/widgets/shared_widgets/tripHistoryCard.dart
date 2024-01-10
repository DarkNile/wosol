import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_container_card_with_border.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_map_iamge_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_row_with_arrow_widget.dart';

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
    return CustomContainerCardWithBorderWidget(
      child: Padding(
        padding: AppConstants.edge(padding: const EdgeInsets.all(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomMapImageWidget(image: "assets/images/map_details.png"),
            const SizedBox(height: 13),
            CustomRowWithArrowWidget(
              from: fromCity,
              to: toCity,
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: AppFonts.medium.copyWith(color: AppColors.darkGreyHint),
            ),
            const SizedBox(height: 8),
            CustomRowWithArrowWidget(
              from: 'Ride details',
              to: 'toCity',
              isHeader: false,
              isButton: true,
              onTapButton: () {},
            ),
          ],
        ),
      ),
    );
  }
}
