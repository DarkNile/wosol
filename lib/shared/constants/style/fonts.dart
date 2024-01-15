import 'package:flutter/material.dart';

import 'colors.dart';

class AppFonts {
  static TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    fontFamily: 'Urbanist',
  );

  static TextStyle button = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Urbanist',
  );

  static TextStyle medium = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    fontFamily: 'Urbanist',
  );
  static TextStyle small = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBlueGrey,
    fontFamily: 'Urbanist',
  );
  static TextStyle style12Urb = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBlue400,
    fontFamily: 'Urbanist',
  );

  static TextStyle unSelectedStyle = const TextStyle(
    color: Color(0xFFA1AECB),
    fontSize: 10,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w500,
  );
  static TextStyle SelectedStyle = const TextStyle(
    color: Color(0xFFA1AECB),
    fontSize: 10,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w600,
  );
}
