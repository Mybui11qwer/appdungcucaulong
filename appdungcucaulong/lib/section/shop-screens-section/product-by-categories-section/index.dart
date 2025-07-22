import 'package:appdungcucaulong/class/index.dart';
import 'package:appdungcucaulong/components/custom-sliver-grid/index.dart';
import 'package:appdungcucaulong/components/parralel-text/index.dart';
import 'package:appdungcucaulong/components/product-card/index.dart';
import 'package:appdungcucaulong/const/raw.dart';
import 'package:flutter/material.dart';

class ProductByCategories extends StatefulWidget {
  final String categoryTitle;

  const ProductByCategories({super.key, required this.categoryTitle});

  @override
  State<ProductByCategories> createState() => _ProductByCategoriesState();
}

class _ProductByCategoriesState extends State<ProductByCategories> {
  late ProdutCardModel product;

  // tạm để
  void handleCategoriesModel(String categories) {
    if (categories.isEmpty) {
      product = Raw.produtCardModel; // Sản phẩm mặc định nếu không có danh mục
    } else if (categories == "Racket") {
      product = Raw.produtCardModelRacket; // Sản phẩm cho racket
    } else if (categories == "Sneaker") {
      product =
          Raw.produtCardModelSneaker; // Mặc định nếu không khớp với điều kiện
    } else if (categories == 'Wrist bands') {
      product = Raw.produtCardModelWristBand;
    }
  }

  @override
  Widget build(BuildContext context) {
    final BoxSize boxSize = BoxSize(
      height: 100,
      width: 100,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
    final double screenWidth = MediaQuery.of(context).size.width;

    //Gọi hàm để biết lọc ra sản phẩm nào
    handleCategoriesModel(widget.categoryTitle);

    return Container(
      width: screenWidth - 20,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ParrallelText(
            text1: "Best ${widget.categoryTitle}",
            text2: 'View More',
          ),
          SizedBox(height: 15),
          CustomSilverGrid(
            quantity: 2,
            gridHeight: 320,
            aspectRatio: 0.57,
            itemBuilder: (context, index) {
              return ProductCardVer2(boxSize: boxSize, product: product);
            },
          ),
        ],
      ),
    );
  }
}
