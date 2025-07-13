import 'package:flutter/material.dart';

class CustomSingleScroll extends StatelessWidget {
  final List<Widget> sons;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final EdgeInsetsGeometry? padding;

  const CustomSingleScroll({
    super.key,
    required this.sons, 
    this.top, this.bottom, 
    this.right, this.left, 
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: SingleChildScrollView(
        padding: padding,
        child: SafeArea(
          child: Column(
            children: List<Widget>.from(sons),
          )),
      ),
    );
  }
}
