import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class UserTripDetailWidget extends StatelessWidget {
  // will add model as final here
  const UserTripDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _CustomLocationRowWidget(
        location: 'FR8C+HXF, At Taniem, Makkah 24224',
        time: 'today'.tr,
        isFrom: true,
      ),
      const _DotWidget(true),
      _CustomRowWidget(
        location: 'home'.tr,
        time: '10:05 ${"am".tr}',
        isFrom: true,
      ),
      const _DotWidget(false),
       _CustomRowWidget(
        location: 'King Abdelaziz University ',
        time: '04:05 ${"pm".tr}',
        isFrom: false,
      ),
      const _DotWidget(true),
      const _CustomLocationRowWidget(
        location: 'FR8C+HXF, At Taniem, Makkah 24224',
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
        Text(location,
            style: AppFonts.button.copyWith(
                fontSize: 16.0.sp(context), color: AppColors.black800)),
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
                      fontSize: 11.0.sp(context),
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
