import 'package:appdungcucaulong/const/styled.dart';
import 'package:flutter/material.dart';
import 'package:appdungcucaulong/class/index.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/components/parallel-widget/index.dart';

class ProductCardVer2 extends StatefulWidget {
  final String? type;
  final BoxSize? boxSize;
  final ProdutCardModel? product;

  const ProductCardVer2({
    super.key,
    this.type,
    this.product,
    required this.boxSize,
  });

  @override
  State<ProductCardVer2> createState() => _ProductCardVer2State();
}

class _ProductCardVer2State extends State<ProductCardVer2> {
  ProductCardType _productCardType = ProductCardType();

  void handleCardType(String? type) {
    if (type == 'normal') {
      _productCardType = ProductCardType(
        type: type,
        txtColor: Colors.blue,
        bgColor: Color.fromARGB(255, 243, 242, 242),
      );
    } else if (type == 'speacial') {
      _productCardType = ProductCardType(
        type: type,
        txtColor: Colors.black,
        bgColor: const Color.fromARGB(255, 207, 198, 198),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    handleCardType(widget.type ?? 'normal');
    return ClipRRect(
      // xài clipRect để cái border radius nó tròn đẹp hơn
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: widget.boxSize!.width,
        margin: widget.boxSize!.margin,
        padding: widget.boxSize!.padding,
        decoration: BoxDecoration(
          color: _productCardType.bgColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                   Center(
                    child: Image.asset(
                      widget.product!.imgSrc,
                      height: 100,
                      width: 100,
                    ),
                   ),
                   Positioned(
                    top: 0,
                    right: 10,
                    child: _productCardType.type == 'normal' 
                      ? Container() 
                      : Icon(Icons.beenhere_sharp, color: Colors.orange,)
                    ),  
                ],
            ),),
            SizedBox(height: 10),
            ParallelWidget(
              widget1: CustomTitle(
                text: "${widget.product!.price.round().toString()} đ",
                fontWeight: FontWeight.bold,
                color: _productCardType.txtColor,
                txtSize: 18,
              ),
              widget2: Icon(
                Icons.favorite_border,
                weight: 200,
                size: 22,
                color: _productCardType.txtColor,
              ),
            ),
            SizedBox(height: 10),
            CustomTitle(
              text: widget.product!.productName,
              textStyle: TextStyled.s4,
            ),
            SizedBox(height: 25),
            ParallelWidget(
              widget1: CustomTitle(
                text: widget.product!.productCategory,
                txtSize: 14,
                color: TextStyled.subCL,
              ),
              widget2: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: _productCardType.txtColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
