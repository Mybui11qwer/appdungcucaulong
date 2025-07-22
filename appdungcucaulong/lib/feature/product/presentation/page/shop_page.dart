import 'package:appdungcucaulong/components/custom-position-circle/index.dart';
import 'package:appdungcucaulong/components/custom-single-sroll/index.dart';
import 'package:appdungcucaulong/config/shared/widget/main_scaffold.dart';
import 'package:appdungcucaulong/feature/product/domain/di/product_injection.dart';
import 'package:appdungcucaulong/feature/product/presentation/bloc/product_event.dart';
import 'package:appdungcucaulong/feature/product/presentation/components/product_category_section.dart';
import 'package:appdungcucaulong/feature/product/presentation/components/top_seller_section.dart';
import 'package:appdungcucaulong/section/shop-screens-section/categories-section/index.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double radius = 320; // Bán kính hình tròn
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => injectProductBloc()..add(LoadProductsEvent()),
      child: MainScaffold(
        currentIndex: 1,
        body: Stack(
          children: [
            CustomSingleScroll(
              top: 30,
              bottom: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              sons: [
                CatergoriesSection(),
                TopSellerSectionBloc(),
                ProductCategorySectionBloc( category: "Rackets",),
                ProductCategorySectionBloc( category: "Sneakers",)
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
      ),
    );
  }
}