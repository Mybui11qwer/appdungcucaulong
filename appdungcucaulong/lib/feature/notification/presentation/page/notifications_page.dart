import 'package:flutter/material.dart';

import '../../../../config/shared/widget/empty_state_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateWidget(
      icon: Icons.notifications_off,
      message: "NO NOTIFICATIONS",
      backgroundColor: Colors.white,
      iconColor: Colors.grey,
      currentIndex: 1,
    );
  }
}
