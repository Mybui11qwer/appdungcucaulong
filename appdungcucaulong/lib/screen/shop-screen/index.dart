import 'package:appdungcucaulong/components/custom-position-circle/index.dart';
import 'package:appdungcucaulong/components/custom-single-sroll/index.dart';
import 'package:appdungcucaulong/section/shop-screens-section/categories-section/index.dart';
import 'package:appdungcucaulong/section/shop-screens-section/product-by-categories-section/index.dart';
import 'package:appdungcucaulong/section/shop-screens-section/top-seller-section/index.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double radius = 320; // Bán kính hình tròn
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomSingleScroll(
            top: 0,
            bottom: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            sons: [
              CatergoriesSection(),
              TopSellerSection(),
              ProductByCategories(categoryTitle: 'Racket'),
              ProductByCategories(categoryTitle: 'Sneaker'),
              ProductByCategories(categoryTitle: 'Wrist bands'),
            ]
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
