import 'package:appdungcucaulong/class/index.dart';
import 'package:appdungcucaulong/components/custom-sliver-grid/index.dart';
import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:appdungcucaulong/components/product-card/index.dart';
import 'package:appdungcucaulong/const/raw.dart';
import 'package:appdungcucaulong/const/styled.dart';
import 'package:flutter/material.dart';

class TopSaleProducts extends StatefulWidget {
  final String categoryTitle;

  const TopSaleProducts({super.key, required this.categoryTitle});

  @override
  State<TopSaleProducts> createState() => _TopSaleProductsState();
}

class _TopSaleProductsState extends State<TopSaleProducts> {
  final BoxSize boxSize = BoxSize(height: 400, width: 400 ,padding: const EdgeInsets.all(10));
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              CustomTitle(
                text: "Top ${widget.categoryTitle}",
                textStyle: TextStyled.h4,
              ),
              SizedBox(width: 5),
              Icon(Icons.stars, color: Colors.amber,size: 24,),
            ],
          ),
          SizedBox(height: 15,),
          SizedBox(
            height: 300,
            width: 500,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              width: screenWidth-20,
              child: CustomSilverGrid(
                quantity: 2,
                aspectRatio: 0.62,
                itemBuilder: ((context, index) => ProductCardVer2(boxSize: boxSize, product: Raw.produtCardModel,type: 'speacial',)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
