import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF3843FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color bg = Color(0xFFF6F9FF);
  static const Color text = Color(0xFF040415);
  static const Color subText = Color(0xFF9B9BA1);
  static const Color error = Color(0xFFDD343F);
}

class AppTextStyle {
  static TextStyle xsSB = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.text,
    ),
  );
  static TextStyle lgSB = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.text,
    ),
  );
  static TextStyle mRegular = GoogleFonts.montserrat(
    textStyle: const TextStyle(fontSize: 15),
  );

  static TextStyle smSB = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
  );
}

var boxShadow2 = [
  BoxShadow(
    blurRadius: 24,
    // blurStyle: ,
    color: Colors.blueGrey.withOpacity(0.12),
    offset: const Offset(0, -10),
    spreadRadius: 20,
  ),
];
var boxShadow1 = [
  BoxShadow(
    blurRadius: 24,
    // blurStyle: ,
    color: Colors.blueGrey.withOpacity(0.12),
    offset: const Offset(0, 20),
    spreadRadius: 20,
  ),
];
