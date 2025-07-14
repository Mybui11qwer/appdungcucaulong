import 'package:appdungcucaulong/components/custom-title/index.dart';
import 'package:flutter/material.dart';

//2 đoạn text trên cùng 1 hàng
class ParrallelText extends StatelessWidget {
  final String text1;
  final String text2;
  const ParrallelText({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTitle(
          text: text1,
          fontWeight: FontWeight.bold,
          txtSize: 18,
        ),
        CustomTitle(
          text: text2,
          fontWeight: FontWeight.bold,
          txtSize: 16,
          color: Colors.blue,
        ),
      ],
    );
  }
}
