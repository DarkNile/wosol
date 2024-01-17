import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/services/local/cache_helper.dart';

class LocalizationController extends GetxController {
  var _locale = const Locale('en');

  Locale currentLocale() {
    String lan = CacheHelper.getData(
          key: 'locale',
        ) ??
        "en";
    return Locale(lan);
  }

  Future<void> changeLocale(Locale newLocale) async {
    _locale = newLocale;
    await CacheHelper.setData(
      key: 'locale',
      value: newLocale.languageCode,
    );
    await Get.updateLocale(newLocale);
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
