import 'package:flutter/material.dart';

class BoxSize {
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  BoxSize({
    required this.height,
    required this.width,
    this.margin,
    this.padding,
  });
}


class ProdutCardModel {
  final String imgSrc;
  final double price;
  final String id;
  final String productName;
  final String productCategory;

  ProdutCardModel({
    required this.imgSrc,
    required this.price,
    required this.id,
    required this.productName,
    required this.productCategory,
  });
}

class SortingOption {
  final String option;
  final IconData optIcon;

  SortingOption({required this.optIcon, required this.option});
}
