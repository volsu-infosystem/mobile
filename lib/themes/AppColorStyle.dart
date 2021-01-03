import 'package:flutter/material.dart';

/// Шаблон для определния всех цветов в приложении
abstract class AppColorStyle {
  MaterialColor materialColor(int hex) {
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

  AppColors get colors;
}

class AppColors {
  MaterialColor background;
  MaterialColor foreground;

  MaterialColor primary;

  AppColors({
    this.background,
    this.foreground,
    this.primary,
  });
}

class LightColorStyle extends AppColorStyle {
  @override
  AppColors get colors => AppColors(
        primary: materialColor(0xff2B82D8),
        background: materialColor(0xffffffff),
        foreground: materialColor(0xff000000),
      );
}

class DarkColorStyle extends AppColorStyle {
  @override
  AppColors get colors => AppColors(
        primary: materialColor(0xff2B82D8),
        background: materialColor(0xff333333),
        foreground: materialColor(0xffffffff),
      );
}
