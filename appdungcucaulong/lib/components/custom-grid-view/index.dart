import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final List<Widget> sons; // Các phần tử con
  final int crossAxisCount; // số lượng phần tử trên 1 dòng
  final double? mainAxisSpace;
  final double? crossAxisSpace;
  final EdgeInsetsGeometry? padding;

  const CustomGridView({
    super.key,
    required this.crossAxisCount,
    required this.sons,  this.padding,  this.crossAxisSpace,  this.mainAxisSpace,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: padding,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpace ?? 10,
      crossAxisSpacing: crossAxisSpace ?? 10,
      children: List<Widget>.from(sons),
    );
  }
}
