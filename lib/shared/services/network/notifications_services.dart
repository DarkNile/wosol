import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> onInit() async {
    await isAndroidPermissionGranted();
    await requestPermissions();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;
        if (notification != null) {
          if (!Platform.isIOS) {
            androidForegroundNotification(
              title: notification.title ?? '',
              body: notification.body,
              imageUrl: notification.android?.imageUrl,
            );
          }
        }
      });

      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
        if (message != null) {
          final notification = message.notification;
          if (notification != null) {
            if (!Platform.isIOS) {
              androidForegroundNotification(
                title: notification.title ?? '',
                body: notification.body,
                imageUrl: notification.android?.imageUrl,
              );
            }
          }
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        final notification = message.notification;
        if (notification != null) {
          if (!Platform.isIOS) {
            androidForegroundNotification(
              title: notification.title ?? '',
              body: notification.body,
              imageUrl: notification.android?.imageUrl,
            );
          }
        }
      });
    }
  }

  Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled();
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
    } else if (Platform.isAndroid) {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
      );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }
  }

  int generateNotificationId() {
    Random random = Random();
    int randomNumber = random.nextInt(900000) + 100000; // Generates a random 6-digit number
    return randomNumber;
  }

  Future<Uint8List> getImageBytes(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    return response.bodyBytes;
  }

  void androidForegroundNotification({
    required String title,
    String? body,
    String? imageUrl,
  }) async {
    BigPictureStyleInformation? bigPictureStyleInformation;
    if (imageUrl != null) {
      await getImageBytes(imageUrl).then((bodyBytes) {
        bigPictureStyleInformation = BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(base64.encode(bodyBytes)),
        );
      });
    }

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Fcm', 'Foreground',
      channelDescription: 'FCM while app is foreground',
      priority: Priority.high,
      importance: Importance.max,
      styleInformation: bigPictureStyleInformation,
      //icon: "assets/app-icon.png"
    );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      generateNotificationId(),
      title,
      body,
      notificationDetails,
    );
  }
}