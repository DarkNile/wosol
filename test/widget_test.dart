// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wosol/controllers/captain_controllers/notification_driver_controller.dart';
import 'package:wosol/controllers/captain_controllers/tracking_driver_controller.dart';

import 'package:wosol/main.dart';
import 'package:wosol/shared/services/network/dio_helper.dart';

void main() {
  group("Just Test", () {
    test('Tracking Add', () async {
      DioHelper.init();
      // await TripHistoryStudentController().getTripsHistory();
      await TrackingDriverController().trackingAdd(
        tripId: '27',
        vehicleId: '1',
        mapLat: '30.115545',
        mapLong: '31.115545',
      );
    });

    test('Get Notifications', () async {
      DioHelper.init();
      // await TripHistoryStudentController().getTripsHistory();
      await NotificationDriverController().getNotifications();
    });

    test('Notification Set Read', () async {
      DioHelper.init();
      // await TripHistoryStudentController().getTripsHistory();
      await NotificationDriverController().notificationSetRead(
        notificationId: '1',
      );
    });
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
