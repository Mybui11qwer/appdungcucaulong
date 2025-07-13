import 'package:appdungcucaulong/components/custom-position-circle/index.dart';
import 'package:appdungcucaulong/components/custom-single-sroll/index.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double radius = 240; // Bán kính hình tròn
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Stack(
        children: [
          CustomPositionCircle(
            moveTop: 40,
            moveLeft: 80,
            radius: radius,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          CustomSingleScroll(
            top: 100,
            bottom: 0,
            padding: const EdgeInsets.all(10),
            sons: [
              
            ]
          )
        ],
      ),
    );
  }
}
