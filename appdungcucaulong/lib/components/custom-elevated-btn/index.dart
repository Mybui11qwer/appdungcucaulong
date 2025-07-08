import 'package:flutter/material.dart';

class CustomelElevatebutton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomelElevatebutton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,  
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Màu nền của nút
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 24
            ), // Đặt màu chữ ở đây
        ),
      ),
    );
  }
}