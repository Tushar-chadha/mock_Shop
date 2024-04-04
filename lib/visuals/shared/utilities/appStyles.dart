import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle poppinStyle(Color textColor, double fontSize, FontWeight fontWeight) {
  return GoogleFonts.poppins(
      color: textColor, fontSize: fontSize, fontWeight: fontWeight);
}

TextStyle poppinStyleHeight(
    Color textColor, double fontSize, FontWeight fontWeight, double height) {
  return GoogleFonts.poppins(
      height: height,
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight);
}

Color commonBackground = const Color(0xFFE2E2E2);
