import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/services/local/cache_helper.dart';

class LocalizationController extends GetxController {
  var _locale = const Locale('en');

  Locale get currentLocale => _locale;

  void changeLocale(Locale newLocale) {
    _locale = newLocale;
    CacheHelper.setData(
      key: 'locale',
      value: newLocale.languageCode,
    );
    Get.updateLocale(newLocale);
    update();
  }

  @override
  void onInit() {
    final storedLocale = CacheHelper.getData(key: 'locale');
    if (storedLocale != null) {
      _locale = Locale(storedLocale);
      Get.updateLocale(_locale);
    }
    super.onInit();
  }
}
