import 'package:appdungcucaulong/const/styled.dart';
import 'package:flutter/material.dart';
import 'package:appdungcucaulong/class/index.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/components/parallel-widget/index.dart';

class ProductCardVer2 extends StatefulWidget {
  final BoxSize? boxSize;
  final ProdutCardModel? product;
  const ProductCardVer2({super.key, required this.boxSize, this.product});

  @override
  State<ProductCardVer2> createState() => _ProductCardVer2State();
}

class _ProductCardVer2State extends State<ProductCardVer2> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // xài clipRect để cái border radius nó tròn đẹp hơn
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: widget.boxSize!.width,
        margin: widget.boxSize!.margin,
        padding: widget.boxSize!.padding,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 243, 242, 242),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 6),
            ),
          ],
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
              child: Center(
                child: Image.asset(
                  widget.product!.imgSrc,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            SizedBox(height: 10),
            ParallelWidget(
              widget1: CustomTitle(
                text: "${widget.product!.price.toString()} đ",
                textStyle: ColorTextStyled.BoldTextH2,
              ),
              widget2: Icon(
                Icons.favorite_border,
                weight: 200,
                size: 22,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            CustomTitle(text: widget.product!.productName, textStyle: TextStyled.s4),
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
                  color: Colors.blue,
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
