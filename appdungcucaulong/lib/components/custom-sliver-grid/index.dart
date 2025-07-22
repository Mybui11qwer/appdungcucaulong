import 'package:flutter/material.dart';

class CustomSilverGrid extends StatelessWidget {
  final double? gridHeight;
  final int? quantity;
  final double? aspectRatio;
  final Function itemBuilder;

  const CustomSilverGrid({
    super.key,
    this.gridHeight,
    this.quantity,
    this.aspectRatio,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // Kiểm tra nếu quantity là null thì đặt giá trị mặc định là 0
    int itemCount = quantity ?? 0;

    return Container(
      height: gridHeight, // Đặt chiều cao cho GridView
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: itemCount, // Số phần tử trong GridView
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2, // Số cột
          childAspectRatio: aspectRatio ?? 0.62, // Giữ tỷ lệ chiều rộng và chiều cao
        ),
        itemBuilder: (context, index) => itemBuilder(context, index), // Gọi itemBuilder
      ),
    );
  }
}
