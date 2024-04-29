import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';

import 'colors.dart';

class AppFonts {
  static TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    fontFamily: AppConstants.isEnLocale? 'Urbanist' : 'Noto',
  );

  static TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: AppConstants.isEnLocale? 'Urbanist' : 'Noto',
  );

  static TextStyle medium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    fontFamily: AppConstants.isEnLocale? 'Urbanist' : 'Noto',
  );
  static TextStyle small = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBlueGrey,
    fontFamily: AppConstants.isEnLocale? 'Urbanist' : 'Noto',
  );
  static TextStyle style12Urb = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBlue400,
    fontFamily: AppConstants.isEnLocale? 'Urbanist' : 'Noto',
  );

  static TextStyle unSelectedStyle = TextStyle(
    color: const Color(0xFFA1AECB),
    fontSize: 10,
    fontFamily: AppConstants.isEnLocale? 'Urbanist' : 'Noto',
    fontWeight: FontWeight.w500,
  );
  static TextStyle selectedStyle = TextStyle(
    color: const Color(0xFFA1AECB),
    fontSize: 10,
    fontFamily: AppConstants.isEnLocale? 'Urbanist' : 'Noto',
    fontWeight: FontWeight.w600,
  );
}
