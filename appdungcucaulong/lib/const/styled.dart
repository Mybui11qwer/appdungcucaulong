import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyled {
  static const mainCL = Colors.black;
  static const subCL = Colors.black54;

  //title
  static final h1 = GoogleFonts.poppins(
    fontSize: 32,
    color: mainCL,
    fontWeight: FontWeight.bold,
  );

  static final h2 = GoogleFonts.poppins(
    fontSize: 28,
    color: mainCL,
    fontWeight: FontWeight.bold,
  );

  static final h3 = GoogleFonts.poppins(
    fontSize: 24,
    color: mainCL,
    fontWeight: FontWeight.bold,
  );

  static final h4 = GoogleFonts.poppins(
    fontSize: 20,
    color: mainCL,
    fontWeight: FontWeight.bold,
  );

  static final h5 = GoogleFonts.poppins(
    fontSize: 16,
    color: mainCL,
    fontWeight: FontWeight.bold,
  );

  //subtitle
  static final s1 = GoogleFonts.poppins(
    fontSize: 28,
    color: subCL,
    fontWeight: FontWeight.normal,
  );

  static final s2 = GoogleFonts.poppins(
    fontSize: 24,
    color: subCL,
    fontWeight: FontWeight.normal,
  );

  static final s3 = GoogleFonts.poppins(
    fontSize: 20,
    color: subCL,
    fontWeight: FontWeight.normal,
  );

  static final s4 = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  //paragraph
  static final p1 = GoogleFonts.poppins(
    fontSize: 24,
    color: mainCL,
    fontWeight: FontWeight.normal,
  );

  static final p2 = GoogleFonts.poppins(
    fontSize: 20,
    color: mainCL,
    fontWeight: FontWeight.normal,
  );

  static final p3 = GoogleFonts.poppins(
    fontSize: 16,
    color: mainCL,
    fontWeight: FontWeight.normal,
  );

  static final p4 = GoogleFonts.poppins(
    fontSize: 14,
    color: mainCL,
    fontWeight: FontWeight.normal,
  );

  static final p5 = GoogleFonts.poppins(
    fontSize: 12,
    color: mainCL,
    fontWeight: FontWeight.normal,
  );
}

class ColorTextStyled {
  static const success = Colors.blue;
  static const danger = Colors.redAccent;

  static final SuccessText = GoogleFonts.poppins(
    fontSize: 38,
    fontWeight: FontWeight.bold,
    color: success,
  );

  static final BoldTextH1 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: success,
  );

  static final BoldTextH2 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: success,
  );

  static final BoldTextH3 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: success,
  );

  
}
