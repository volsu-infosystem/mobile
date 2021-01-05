import 'package:flutter/material.dart';

/// Шаблон для определния всех цветов в приложении
abstract class AppAppearanceGenerator {
  MaterialColor matColor(int hex) {
    final color = Color(hex);
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  AppAppearance get colors;
}

class AppAppearance {
  MaterialColor background;
  MaterialColor foreground;
  MaterialColor foregroundOnPrimary;

  MaterialColor primary;
  MaterialColor errorText;

  MaterialColor inputBorders;

  MaterialColor splashOnBackground;

  AppAppearance({
    @required this.background,
    @required this.foreground,
    @required this.primary,
    @required this.errorText,
    @required this.inputBorders,
    @required this.foregroundOnPrimary,
    @required this.splashOnBackground,
  });
}

class LightAppAppearance extends AppAppearanceGenerator {
  // TODO: Оптимизировать генерацию цветов. Сейчас функция [matColor()] вызывается каждый раз при обращении к [colors], хотя по логике эта функция должна быть вообще compile-time const. В крайнем случай, runtime const с ленивой инициализацией
  @override
  AppAppearance get colors => AppAppearance(
        primary: matColor(0xff2B82D8),
        background: matColor(0xffffffff),
        foreground: matColor(0xff000000),
        errorText: matColor(0xffff0000),
        inputBorders: matColor(0xffD7D7D7),
        foregroundOnPrimary: matColor(0xffffffff),
        splashOnBackground: matColor(0xffE5E5E5),
      );
}

// class DarkAppAppearance extends AppAppearanceGenerator {
//   @override
//   AppAppearance get colors => AppAppearance(
//         primary: matColor(0xff2B82D8),
//         background: matColor(0xff333333),
//         foreground: matColor(0xffffffff),
//         error: matColor(0xffff0000),
//       );
// }
