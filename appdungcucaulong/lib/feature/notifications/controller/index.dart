import 'package:get/get.dart';

class NotificationsController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[
    NotificationModel(
      id: '1',
      title: 'Order Shipped',
      date: DateTime.now(),
      content: 'Your order has been shipped and is on its way!',
      orderId: 'ORD001',
      status: 'shipped',
      readStatus: false,
    ),
    NotificationModel(
      id: '2',
      title: 'New Promotion',
      date: DateTime.now().subtract(Duration(hours: 3)),
      content: 'Check out our latest deals available for today only.',
      orderId: 'PROMO2025',
      status: 'info',
      readStatus: true,
    ),
    NotificationModel(
      id: '3',
      title: 'Order Delivered',
      date: DateTime.now().subtract(Duration(days: 1)),
      content: 'Your order #ORD002 has been delivered successfully.',
      orderId: 'ORD002',
      status: 'delivered',
      readStatus: false,
    ),
    NotificationModel(
      id: '4',
      title: 'Order Cancelled',
      date: DateTime.now().subtract(Duration(days: 2)),
      content: 'Your order #ORD003 has been cancelled.',
      orderId: 'ORD003',
      status: 'cancelled',
      readStatus: true,
    ),
  ].obs;

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1 && !notifications[index].readStatus) {
      notifications[index].readStatus = true;
      notifications.refresh(); // vì là object, cần refresh để cập nhật UI
    }
  }
}


class NotificationModel {
  final String id;
  final String title;
  final DateTime date;
  final String content;
  final String orderId;
  final String status;
  bool readStatus;

  NotificationModel({
    required this.id,
    required this.title,
    required this.date,
    required this.content,
    required this.orderId,
    required this.status,
    this.readStatus = false,
  });
}
