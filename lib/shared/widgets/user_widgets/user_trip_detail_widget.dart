import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class UserTripDetailWidget extends StatelessWidget {
  // Details
  final String fromLocation;
  final String fromTitle;
  final String toLocation;
  final String toTitle;
  final String date;
  final String fromTime;
  final String toTime;
  const UserTripDetailWidget(
      {super.key,
      required this.fromLocation,
      required this.fromTitle,
      required this.toLocation,
      required this.toTitle,
      required this.date,
      required this.fromTime,
      required this.toTime});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _CustomLocationRowWidget(
        location: fromLocation,
        time: date,
        isFrom: true,
      ),
      const _DotWidget(true),
      _CustomRowWidget(
        location: fromTitle,
        time: fromTime,
        isFrom: true,
      ),
      const _DotWidget(false),
      _CustomRowWidget(
        location: toTitle,
        time: toTime,
        isFrom: false,
      ),
      const _DotWidget(true),
      _CustomLocationRowWidget(
        location: toLocation,
        time: null,
        isFrom: false,
      ),
    ]);
  }
}

class _CustomRowWidget extends StatelessWidget {
  final String location;
  final String? time;
  final bool isFrom;

  const _CustomRowWidget(
      {required this.location, required this.time, required this.isFrom});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(children: [
        SizedBox(
          width: 66 + 6,
          child: Row(children: [
            if (time != null)
              Text(time ?? "",
                  style: AppFonts.button.copyWith(
                      fontSize: 13,
                      color: isFrom
                          ? AppColors.black800
                          : AppColors.darkBlue500Base)),
            const Spacer(),
            isFrom
                ? Container(
                    width: 6,
                    height: 6,
                    decoration: const ShapeDecoration(
                      color: AppColors.logo,
                      shape: OvalBorder(),
                    ),
                  )
                : Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(color: AppColors.logo),
                  )
          ]),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(location,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.button.copyWith(
                  fontSize: Get.width > 375 ? 16.0.sp(context) : 13.5,
                  color: AppColors.black800)),
        ),
      ]),
    );
  }
}

class _CustomLocationRowWidget extends StatelessWidget {
  final String location;
  final String? time;
  final bool isFrom;

  const _CustomLocationRowWidget(
      {required this.location, required this.time, required this.isFrom});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(children: [
        SizedBox(
          width: 66 + 6,
          child: Row(children: [
            if (time != null)
              Text(time ?? "",
                  style: AppFonts.button.copyWith(
                      fontSize:
                          Get.width > 375 ? 11.0.sp(context) : 8.5.sp(context),
                      color: AppColors.darkBlue400)),
            const Spacer(),
            isFrom
                ? Container(
                    width: 6,
                    height: 6,
                    decoration: const ShapeDecoration(
                      color: AppColors.darkBlue300,
                      shape: OvalBorder(),
                    ),
                  )
                : Container(
                    width: 6,
                    height: 6,
                    decoration:
                        const BoxDecoration(color: AppColors.darkBlue300),
                  )
          ]),
        ),
        const SizedBox(
          width: 10,
        ),
        SvgPicture.asset('assets/icons/location.svg'),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(location,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.button.copyWith(
                  fontSize: 13.0.sp(context),
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkBlue300)),
        ),
      ]),
    );
  }
}

class _DotWidget extends StatelessWidget {
  final bool isLocation;
  const _DotWidget(this.isLocation);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66 + 4,
      height: isLocation ? 8 : 14,
      child: Row(children: [
        const Spacer(),
        isLocation
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 1,
                    height: 2,
                    color: AppColors.darkBlue300,
                  ),
                  const SizedBox(height: 1),
                  Container(
                    width: 1,
                    height: 2,
                    color: AppColors.darkBlue300,
                  ),
                  const SizedBox(height: 1),
                  Container(
                    width: 1,
                    height: 2,
                    color: AppColors.darkBlue300,
                  ),
                ],
              )
            : Container(
                width: 1,
                height: 14,
                color: AppColors.logo,
              )
      ]),
    );
  }
}
