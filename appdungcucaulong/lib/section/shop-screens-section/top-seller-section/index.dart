import 'package:appdungcucaulong/const/raw.dart';
import 'package:flutter/material.dart';
import 'package:appdungcucaulong/class/index.dart';
import 'package:appdungcucaulong/components/custom-grid-view/index.dart';
import 'package:appdungcucaulong/components/parralel-text/index.dart';
import 'package:appdungcucaulong/components/product-card/index.dart';

class TopSellerSection extends StatelessWidget {
  const TopSellerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final BoxSize boxSize = BoxSize(
      height: 100,
      width: 100,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth - 20,
      child: Column(
        children: [
          ParrallelText(text1: 'Best Seller', text2: 'View All'),
          SizedBox(height: 15),
          Container(
            height: 600, // Đặt chiều cao cho GridView
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4, // Số phần tử trong GridView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 16,
                crossAxisSpacing: 10,
                crossAxisCount: 2, // Số cột
                childAspectRatio: 0.62, // Giữ tỷ lệ chiều rộng và chiều cao
              ),
              itemBuilder: (context, index) {
                return ProductCardVer2(boxSize: boxSize, product: Raw.produtCardModel,);
              },
            ),
          ),
        ],
      ),
    );
  }
}
