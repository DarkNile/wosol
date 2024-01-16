import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/lang/localization.dart';
import 'package:wosol/shared/services/local/cache_helper.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';
import 'package:wosol/view/shared_screens/auth/settings_screen.dart';
import 'package:wosol/view/shared_screens/main_screens/layout_screen/layout_screen.dart';
import 'package:wosol/view/shared_screens/notification_screen.dart';
import 'package:wosol/view/shared_screens/trip_history/trip_history_screen.dart';

import 'controllers/shared_controllers/main_controllers/localization_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ));
  // runApp(
  //   const MyApp(),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.logo),
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(
          LocalizationController(),
          permanent: true,
        );
      }),
      translations: Localization(),
      locale: Locale(CacheHelper.getData(key: 'locale') ?? "en"),
      fallbackLocale: const Locale("en"),
      home: const LayoutScreen(),
    );
  }
}
