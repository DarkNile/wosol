import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wosol/shared/constants/style/colors.dart';

class RatingBarWidget extends StatelessWidget {
  final double? itemSize;
  final bool? ignoreGestures;
  final EdgeInsetsGeometry? itemPadding;
  final void Function(double) onRatingUpdate;
  const RatingBarWidget(
      {super.key,
      this.itemSize,
      this.ignoreGestures,
      this.itemPadding,
      required this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 5,
      minRating: 1,
      itemSize: itemSize ?? 40,
      direction: Axis.horizontal,
      allowHalfRating: true,
      maxRating: 5,
      itemCount: 5,
      itemPadding: itemPadding ?? const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => SvgPicture.asset('assets/icons/star.svg'),
      //  Icon(
      //   Icons.star,
      //   color: AppColors.starColor,
      // ),
      unratedColor: AppColors.darkBlue100,
      // make it read-only
      ignoreGestures: ignoreGestures ?? false,

      onRatingUpdate: onRatingUpdate,
      updateOnDrag: true,
    );
  }
}
