import 'package:flutter/material.dart';

class CustomPositionCircle extends StatelessWidget {
  final Color? color;
  final double radius;
  final double moveTop; // di chuyển lên xuống
  final double moveLeft; // di chuyển sang trái phải
  final double screenWidth;
  final double screenHeight;

  const CustomPositionCircle({
    super.key,
    this.color,
    required this.radius,
    required this.moveTop,
    required this.moveLeft,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (-radius / 2 - moveTop) * 2, // Đẩy hình tròn ra ngoài một chút ở phía trên // 40
      left: screenWidth - radius - moveLeft - (radius / 2), // Đặt hình tròn ở giữa //80
      child: Container(
        width: radius * 2, // Đặt chiều rộng của hình tròn
        height: radius * 2, // Đặt chiều cao của hình tròn
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Colors.blue, // Màu của hình tròn
        ),
      ),
    );
  }
}