import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/services/network/repositories/user_repositorie.dart';

import '../../controllers/shared_controllers/main_controllers/localization_controller.dart';

class AppConstants {
  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isCaptain = true;
  static String token = '';

  static String googleApiKey = 'AIzaSyCa8FElw75agiPGmjxxbo8aFf5ZkvWchRw';
  
  static final userRepository = Get.find<UserRepository>();
  static final localizationController = Get.find<LocalizationController>();
  static bool get isEnLocale =>
      localizationController.currentLocale().languageCode == 'en';

  static EdgeInsets edge({
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return isEnLocale
        ? EdgeInsets.only(
            left: padding.left,
            right: padding.right,
            top: padding.top,
            bottom: padding.bottom,
          )
        : EdgeInsets.only(
            left: padding.right,
            right: padding.left,
            top: padding.top,
            bottom: padding.bottom,
          );
  }

  static String convertToArOrEnNumerals(String input) {
    const englishDigits = '0123456789';
    const arabicDigits = '٠١٢٣٤٥٦٧٨٩';

    if (localizationController.currentLocale().languageCode == 'ar') {
      for (int i = 0; i < englishDigits.length; i++) {
        input = input.replaceAll(englishDigits[i], arabicDigits[i]);
      }
    } else {
      for (int i = 0; i < englishDigits.length; i++) {
        input = input.replaceAll(arabicDigits[i], englishDigits[i]);
      }
    }

    return input;
  }
}

extension ResponsiveText on double {
  double sp(BuildContext context) {
    double calculatedSize =
        (this / 720) * AppConstants.screenSize(context).height;
    if (AppConstants.screenSize(context).height < 600) {
      return calculatedSize.clamp(this - 4, this);
    } else if (AppConstants.screenSize(context).height > 1080) {
      return calculatedSize.clamp(this, this + 2);
    } else {
      double calculatedSize =
          (this / 720) * AppConstants.screenSize(context).height;
      return calculatedSize.clamp(this - 2, this);
    }
  }
}
