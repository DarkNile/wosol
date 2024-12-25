import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/models/user_attendance_model.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class UserAttendanceCardWidget extends StatelessWidget {
  final UserAttendanceModel userAttendanceModel;

  const UserAttendanceCardWidget({
    super.key,
    required this.userAttendanceModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        border: Border.all(color: AppColors.logo, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // From
            _CustomRowWidget(
              title: "from".tr,
              value: userAttendanceModel.from ?? "",
            ),
            const SizedBox(
              height: 4,
            ),
            // To
            _CustomRowWidget(
              title: "to".tr,
              value: userAttendanceModel.universityName ?? "",
            ),
            const SizedBox(
              height: 4,
            ),
            // Trip Date
            _CustomRowWidget(
              title: "trip date".tr,
              value: userAttendanceModel.tripDate ?? "",
            ),
            const SizedBox(
              height: 4,
            ),
            // Trip Time
            _CustomRowWidget(
              title: "trip time".tr,
              value: userAttendanceModel.tripTime ?? "",
            ),
            const SizedBox(
              height: 4,
            ),
            // Attendance
            _CustomRowWidget(
              title: "attendance".tr,
              value: userAttendanceModel.attendance == true
                  ? "present".tr
                  : "absent".tr,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomRowWidget extends StatelessWidget {
  final String title;
  final String value;
  const _CustomRowWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: AppFonts.style12Urb,
      ),
      Text(
        value,
        style: AppFonts.style12Urb,
      ),
    ]);
  }
}
