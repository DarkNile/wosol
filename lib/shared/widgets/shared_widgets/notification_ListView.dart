import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/notification_card.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const NotificationCard(
            notificationTime: "15 min ago",
            notificationTitle:
                "You canceled trip from Home to King Abdelaziz University",
          );
        });
  }
}
