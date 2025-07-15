import 'package:appdungcucaulong/class/index.dart';
import 'package:appdungcucaulong/components/custom-position-circle/index.dart';
import 'package:appdungcucaulong/components/custom-single-sroll/index.dart';
import 'package:appdungcucaulong/section/category-screens-section/all-category-product-section/index.dart';
import 'package:appdungcucaulong/section/category-screens-section/top-products-section/index.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final double radius = 320; // Bán kính hình tròn
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final BoxSize boxSize = BoxSize(height: 400, width: 400 ,padding: const EdgeInsets.all(10));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomSingleScroll(
            top: 0,
            bottom: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            sons: [
              SizedBox(
                width: screenWidth,
                height: 1000,
                child: Stack(
                  children: [
                    Positioned(
                      top: 100,
                      right: -100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          width: boxSize.width,
                          height: boxSize.height,
                          color: Colors.blue,
                        ),
                        )
                    ),
                    Positioned(
                      top: 500,
                      left: -100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          width: boxSize.width,
                          height: boxSize.height,
                          color: Colors.blue,
                        ),
                        )
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        TopSaleProducts(categoryTitle: widget.category),
                        AllCategoryProductSection(),
                      ],
                    )
                    
                    
                  ],
                ),
              ),
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
