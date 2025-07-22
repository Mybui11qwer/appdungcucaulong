import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/const/styled.dart';
import 'package:appdungcucaulong/feature/notifications/controller/index.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.blue,
              child: Image.asset(
                'assets/images/racket.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
          const SizedBox(width: 12), // Thêm khoảng cách giữa ảnh và text
          Expanded(
            // hoặc Flexible nếu muốn mềm hơn
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  text: notification.title,
                  fontWeight: FontWeight.bold,
                ),
                CustomTitle(
                  text: notification.content,
                  textStyle: TextStyled.p5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
