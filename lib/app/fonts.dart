import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle clashDisplay = TextStyle(
    fontFamily: "ClashDisplay",
    height: lineHeight,
  );

  static TextStyle montserrat = GoogleFonts.montserrat(height: lineHeight);
  static TextStyle nunito = TextStyle(
    fontFamily: "Nunito",
    height: lineHeight,
  );

  static TextStyle poppins = TextStyle(
    fontFamily: "Poppins",
    height: lineHeight,
  );

  static TextStyle sora = TextStyle(
    fontFamily: "Sora",
    height: lineHeight,
  );

  static double get lineHeight => 1.364;
}
