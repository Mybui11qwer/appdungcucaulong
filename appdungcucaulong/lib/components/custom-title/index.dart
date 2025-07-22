import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final Color? color;
  final int? MaxLine;    
  final double? txtSize;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  const CustomTitle({
    super.key,
    this.color,
    this.txtSize,
    this.textStyle,
    this.textAlign,
    this.fontWeight,
    required this.text, this.MaxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      maxLines: MaxLine ?? 2,
      overflow: TextOverflow.fade,
      style:
          textStyle ??
          GoogleFonts.poppins(
            color: color,
            fontSize: txtSize,
            fontWeight: fontWeight,
          ),
    );
  }
}
