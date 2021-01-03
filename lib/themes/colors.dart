import 'package:flutter/material.dart';

/// Шаблон для определния всех цветов в приложении
abstract class AppAppearanceGenerator {
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

  AppAppearance get colors;
}

class AppAppearance {
  MaterialColor background;
  MaterialColor foreground;
  MaterialColor foregroundOnPrimary;

  MaterialColor primary;
  MaterialColor error;

  MaterialColor inputBorders;

  AppAppearance({
    this.background,
    this.foreground,
    this.primary,
    this.error,
    this.inputBorders,
    this.foregroundOnPrimary,
  });
}

class LightAppAppearance extends AppAppearanceGenerator {
  @override
  AppAppearance get colors => AppAppearance(
        primary: materialColor(0xff2B82D8),
        background: materialColor(0xffffffff),
        foreground: materialColor(0xff000000),
        error: materialColor(0xffff0000),
        inputBorders: materialColor(0xffEEEEEE),
        foregroundOnPrimary: materialColor(0xffffffff),
      );
}

// class DarkAppAppearance extends AppAppearanceGenerator {
//   @override
//   AppAppearance get colors => AppAppearance(
//         primary: materialColor(0xff2B82D8),
//         background: materialColor(0xff333333),
//         foreground: materialColor(0xffffffff),
//         error: materialColor(0xffff0000),
//       );
// }
