import 'package:appdungcucaulong/components/custom-position-circle/index.dart';
import 'package:appdungcucaulong/components/custom-single-sroll/index.dart';
import 'package:appdungcucaulong/config/shared/widget/main_scaffold.dart';
import 'package:appdungcucaulong/feature/notifications/presentation/components/notification_list.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double radius = 320; // Bán kính hình tròn
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return MainScaffold(
      currentIndex: 3,
      body: Stack(
        children: [
          CustomSingleScroll(
            top: 80,
            bottom: 0,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            sons: [
              NotificationList()
            ],
          ),
          CustomPositionCircle(
            moveTop: 120,
            moveLeft: 40,
            radius: radius,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }
}