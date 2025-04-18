// import 'package:device_preview/device_preview.dart';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upgrader/upgrader.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/captain_controllers/notification_driver_controller.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/firebase_options.dart';
import 'package:wosol/models/driver_model.dart';
import 'package:wosol/models/user_model.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/dialogs/location_dialog.dart';
import 'package:wosol/shared/lang/localization.dart';
import 'package:wosol/shared/services/local/cache_helper.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';
import 'package:wosol/shared/services/network/notifications_services.dart';
import 'package:wosol/shared/services/network/repositories/home_driver_repository.dart';
import 'package:wosol/shared/services/network/repositories/student_repositorie.dart';
import 'package:wosol/shared/services/network/repositories/user_repositorie.dart';
import 'package:wosol/view/captain_screens/driver_layout_screen.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';
import 'package:wosol/view/user_screens/user_layout_screen.dart';

import 'controllers/shared_controllers/main_controllers/localization_controller.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> checkLocationService() async {
  // Check if location services are enabled
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    print('Location services are disabled. Please enable them.');
    // Optionally, show a dialog or redirect the user to the location settings
    return;
  }

  // Check for location permission
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Request permission
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permission is denied.');
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Handle the case where permissions are permanently denied
    print(
        'Location permissions are permanently denied. Please enable them in settings.');
    return;
  }

  print('Location services are enabled, and permissions are granted.');
}

Future<void> enforceLocationService() async {
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    // Redirect user to enable location services
    await Geolocator.openLocationSettings();
    print('Redirecting user to location settings.');
  }
}

void handleLocationCheck() async {
  await checkLocationService();
  await enforceLocationService();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('en_US');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationServices().onInit();
  await CacheHelper.init();
  await AppConstants.getFcmToken();
  handleLocationCheck();
  // FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
  //   AppConstants.fcmToken = newToken;
  // });
  Get.put(
    UserRepository(),
    permanent: true,
  );
  AppConstants.token = await CacheHelper.getData(key: 'token') ?? '';
  print('token********************************* ${AppConstants.token}');
  AppConstants.isFirst = await CacheHelper.getData(key: 'isFirst') ?? true;
  AppConstants.userType = await CacheHelper.getData(key: 'userType') ?? '';
  if (AppConstants.userType == 'Driver' && AppConstants.token.isNotEmpty) {
    AppConstants.userRepository.driverData = DriverData.fromJson(
        jsonDecode(await CacheHelper.getData(key: 'DriverData')));
  } else if (AppConstants.userType == 'Employee' &&
      AppConstants.token.isNotEmpty) {
    AppConstants.userRepository.employeeData = DriverData.fromJson(
        jsonDecode(await CacheHelper.getData(key: 'EmployeeData')));
  } else if (AppConstants.token.isNotEmpty) {
    AppConstants.userRepository.userData = UserData.fromJson(
        jsonDecode(await CacheHelper.getData(key: 'UserData')));
  }
  Upgrader.clearSavedSettings(); // Clear any saved preferences, if needed
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
    MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.transparent,
      home: UpgradeAlert(
          showIgnore: false,
          showLater: false,
          shouldPopScope: () => false,
          barrierDismissible: false,
          dialogStyle: Platform.isIOS
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
          upgrader: Upgrader(
            debugDisplayAlways: false,
            debugLogging: true,
          ),
          child: const MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (AppConstants.isFirst) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          // if(Platform.isAndroid) {
          //   getLocationPermission(context);
          // } else{
            await Permission.location.request();
            await CacheHelper.setData(
                key: 'isFirst', value: false);
            AppConstants.isFirst =
                await CacheHelper.getData(key: 'isFirst') ??
                true;
          // }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wosol',
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
          HomeDriverRepository(),
        );
        Get.put(
          StudentRepository(),
          permanent: true,
        );
        Get.put(
          NotificationDriverController(),
          permanent: true,
        );
      }),
      translations: Localization(),
      locale: Locale(CacheHelper.getData(key: 'locale') ?? "en"),
      fallbackLocale: const Locale("en"),
      home: AppConstants.token.isEmpty
          ? LoginScreen()
          : (AppConstants.userType == 'Student'
              ? const UserLayoutScreen()
              : const DriverLayoutScreen()),
    );
  }
}
