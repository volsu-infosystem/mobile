import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get instance => _instance; // Singleton

  static MaterialColor materialColor(int hex) {
    return MaterialColor(hex, {
      50: Color(hex).withOpacity(0.1),
      100: Color(hex).withOpacity(0.2),
      200: Color(hex).withOpacity(0.3),
      300: Color(hex).withOpacity(0.4),
      400: Color(hex).withOpacity(0.5),
      500: Color(hex).withOpacity(0.6),
      600: Color(hex).withOpacity(0.7),
      700: Color(hex).withOpacity(0.8),
      800: Color(hex).withOpacity(0.9),
      900: Color(hex).withOpacity(1),
    });
  }

  static final _instance = ThemeData(
    /* 
    * Colors
    */
    primarySwatch: materialColor(0xff2B82D8),

    /*
     * Text styles
     */
    fontFamily: 'Open Sans',
    textTheme: TextTheme(
        // TODO: Определить стили шрифтов
        ),
  );
}
