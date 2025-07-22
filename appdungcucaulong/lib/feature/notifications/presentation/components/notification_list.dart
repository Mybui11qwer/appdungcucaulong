import 'package:appdungcucaulong/feature/notifications/controller/index.dart';
import 'package:appdungcucaulong/feature/notifications/presentation/components/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final NotificationsController _controller = Get.put(
    NotificationsController(),
  );
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth-20,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _controller.notifications
                .map((item) => NotificationCard(notification: item))
                .toList(),
      ),
    );
  }
}
