// import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/lang/localization.dart';
import 'package:wosol/shared/services/local/cache_helper.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';
import 'package:wosol/shared/services/network/repositories/home_driver_repository.dart';
import 'package:wosol/shared/services/network/repositories/student_repositorie.dart';
import 'package:wosol/shared/services/network/repositories/user_repositorie.dart';
import 'package:wosol/view/captain_screens/driver_layout_screen.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';
import 'package:wosol/view/user_screens/user_layout_screen.dart';

import 'controllers/shared_controllers/main_controllers/localization_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  AppConstants.token = await CacheHelper.getData(key: 'token') ?? '';
  // AppConstants.isCaptain = await CacheHelper.getData(key: 'userType') ?? true;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  DioHelper.init();

  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const MyApp(),
  // ));
  runApp(
    const MyApp(),
  );
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
        appBarTheme: const AppBarTheme(
          color: AppColors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.logo),
        scaffoldBackgroundColor: AppColors.dividerColor, // Colors.grey[100],
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(
          MapController(),
          permanent: true,
        );
        Get.put(
          LocalizationController(),
          permanent: true,
        );
        Get.put(
          UserRepository(),
          permanent: true,
        );
        Get.put(
          HomeDriverRepository(),
        );
        Get.put(
          StudentRepository(),
          permanent: true,
        );
      }),
      translations: Localization(),
      locale: Locale(CacheHelper.getData(key: 'locale') ?? "en"),
      fallbackLocale: const Locale("en"),
      home: AppConstants.token.isEmpty
          ? LoginScreen()
          : (AppConstants.isCaptain
              ? DriverLayoutScreen()
              : UserLayoutScreen()),
    );
  }
}
