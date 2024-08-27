import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wosol/shared/services/network/repositories/home_driver_repository.dart';
import 'package:wosol/shared/services/network/repositories/user_repositorie.dart';

import '../../controllers/shared_controllers/main_controllers/localization_controller.dart';
import '../services/network/repositories/employee_repository.dart';
import '../services/network/repositories/student_repositorie.dart';

class AppConstants {
  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static String userType = 'Driver';
  static String userId = '247';
  static String token = '';
  static String? fcmToken = '';
  static bool isFirst = true;

  static String googleApiKey = 'AIzaSyCa8FElw75agiPGmjxxbo8aFf5ZkvWchRw';

  static final userRepository = Get.find<UserRepository>();
  static final homeDriverRepository = Get.find<HomeDriverRepository>();
  static final employeeRepository = Get.find<EmployeeRepository>();
  static final studentRepository = Get.find<StudentRepository>();
  static final localizationController = Get.find<LocalizationController>();
  static bool get isEnLocale =>
      localizationController.currentLocale().languageCode == 'en';

  static void getFcmToken() async {
    AppConstants.fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM Token: ${AppConstants.fcmToken}');
  }

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

  static String formatDateToWeekday(String date, Locale locale) {
    final String formattedDate = DateFormat(
      'EEEE',
    ).format(
      DateTime.parse(date),
    );

    if (locale.languageCode == 'ar') {
      switch (formattedDate) {
        case 'Saturday':
          return 'السبت';
        case 'Sunday':
          return 'الأحد';
        case 'Monday':
          return 'الاثنين';
        case 'Tuesday':
          return 'الثلاثاء';
        case 'Wednesday':
          return 'الأربعاء';
        case 'Thursday':
          return 'الخميس';
        case 'Friday':
          return 'الجمعة';
        default:
          return formattedDate;
      }
    }

    return formattedDate;
  }

  static String getTimeFromDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String hours = dateTime.hour.toString().padLeft(2, '0');
    String minutes = dateTime.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  static String getTimeDifference(String startTime) {
    DateTime startDateTime = DateTime.parse(startTime);
    DateTime currentDateTime = DateTime.now();
    Duration difference = currentDateTime.difference(startDateTime);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    String result = "";
    if (days > 0) result += "${days}days ";
    if (hours > 0) result += "${hours}h ";
    if (minutes > 0) result += "${minutes}m ";
    if (seconds > 0) result += "${seconds}s";

    return result.isEmpty ? "0 seconds" : result.trim();
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
