import 'package:flutter/material.dart';

class AppTextStyles {
  static const opensans = "Open Sans";
  static const montserrat = "Montserrat";

  static const regular = FontWeight.w400;
  static const semibold = FontWeight.w600;
  static const bold = FontWeight.w700;

  static TextStyle get h1 => TextStyle(
        fontFamily: opensans,
        fontWeight: semibold,
        fontSize: 24,
      );

  static TextStyle get largeInput => TextStyle(
        fontSize: 17,
        fontFamily: montserrat,
        fontWeight: semibold,
      );
}

class AppButtonStyles {}
