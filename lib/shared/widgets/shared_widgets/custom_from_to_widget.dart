import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

import '../../constants/style/colors.dart';

class CustomFromToWidget extends StatelessWidget {
  final String formTime;
  final String toTime;
  final String formPlace;
  final String toPlace;
  final String? companyName;
  final String? companyTelephone;
  final String? companyEmail;

  const CustomFromToWidget(
      {super.key,
      required this.formTime,
      required this.toTime,
      required this.formPlace,
      required this.toPlace,
      this.companyName,
      this.companyTelephone,
      this.companyEmail,
      });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // From
      _TimeWidget(time: formTime),
      Row(
        children: [
          const _FromOrToWidget(isFrom: true),
          const SizedBox(width: 6),
          Text(formPlace,
              style: AppFonts.button.copyWith(color: AppColors.black800))
        ],
      ),

      // Divider
      const SizedBox(
        height: 16,
        child: _DotWidget(),
      ),

      // To
      Row(
        children: [
          const _FromOrToWidget(isFrom: false),
          const SizedBox(width: 6),
          Text(toPlace,
              style: AppFonts.button.copyWith(color: AppColors.black800)),
        ],
      ),
      _TimeWidget(time: toTime),
      const SizedBox(height: 10),
      if(companyName != null)
      const Divider(height: 1, color: AppColors.darkBlue100),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(companyName != null)
          Row(
            children: [
              const Icon(Icons.home_work_outlined),
              const SizedBox(width: 12,),
              Text(companyName!,
                  style: AppFonts.button.copyWith(color: AppColors.black800)),
            ],
          ),
          if(companyTelephone != null)
            Row(
              children: [
                const Icon(Icons.phone_outlined),
                const SizedBox(width: 12,),
                Text(companyTelephone!,
                    style: AppFonts.button.copyWith(color: AppColors.black800)),
              ],
            ),
        ],
      ),
      if(companyEmail != null)
      const SizedBox(height: 16),
      if(companyEmail != null)
      Row(
        children: [
          const Icon(Icons.email_outlined),
          const SizedBox(width: 12,),
          Text(companyEmail!,
              style: AppFonts.button.copyWith(color: AppColors.black800)),
        ],
      ),
    ]);
  }
}

// Widgets

class _TimeWidget extends StatelessWidget {
  final String time;
  const _TimeWidget({required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 15 + 16 + 30+6 ,
      child: Row(
        children: [
          const SizedBox(
            width: 15 + 16 + 30 + 6 + 6,
          ),
          // const Spacer(),
          Text(time,
              style: AppFonts.medium.copyWith(
                color: AppColors.darkBlue500Base,
                fontSize: 12.0.sp(context),
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

class _FromOrToWidget extends StatelessWidget {
  final bool isFrom;
  const _FromOrToWidget({required this.isFrom});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 67,
      child: Row(children: [
        Text(isFrom ? "from".tr : "to".tr,
            style: AppFonts.button.copyWith(
                fontSize: 13.0.sp(context),
                fontWeight: FontWeight.w500,
                color: AppColors.darkBlue300)),
        const Spacer(),
        Container(
          height: 15,
          width: 15,
          decoration: ShapeDecoration(
            color: isFrom ? AppColors.success600 : AppColors.error600,
            shape: const OvalBorder(
              side: BorderSide(width: 2, color: Colors.white),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x1E000000),
                blurRadius: 3,
                offset: Offset(0, 3),
                spreadRadius: 0,
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class _DotWidget extends StatelessWidget {
  const _DotWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.5,
      child: Row(children: [
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 6,
              width: 1,
              decoration: const BoxDecoration(
                color: AppColors.success600,
              ),
            ),
            const SizedBox(height: 3),
            Container(
              height: 6,
              width: 1,
              decoration: const BoxDecoration(
                color: AppColors.success600,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
