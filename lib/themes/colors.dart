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
  MaterialColor text;
  MaterialColor textOnPrimary;
  MaterialColor textWeak;
  MaterialColor textOnError;

  MaterialColor primary;
  MaterialColor error;

  MaterialColor inputBorders;

  MaterialColor splashOnBackground;

  MaterialColor iconOnBackground;
  MaterialColor iconOnBackground_selected;

  MaterialColor divider;

  AppAppearance({
    @required this.background,
    @required this.text,
    @required this.primary,
    @required this.error,
    @required this.inputBorders,
    @required this.textOnPrimary,
    @required this.splashOnBackground,
    @required this.textWeak,
    @required this.iconOnBackground,
    @required this.iconOnBackground_selected,
    @required this.textOnError,
    @required this.divider,
  });
}

class WhiteAppAppearance extends AppAppearanceGenerator {
  void _calculateColors() {
    _colors = AppAppearance(
      primary: matColor(0xff2B82D8),
      background: matColor(0xffffffff),
      text: matColor(0xff000000),
      error: matColor(0xffff0000),
      inputBorders: matColor(0xffD7D7D7),
      textOnPrimary: matColor(0xffffffff),
      splashOnBackground: matColor(0xffE5E5E5),
      textWeak: matColor(0xff676767),
      iconOnBackground: matColor(0xff2F2F2F),
      iconOnBackground_selected: matColor(0xff2B82D8),
      textOnError: matColor(0xffffffff),
      divider: matColor(0xffEAEAEA),
    );
  }

  AppAppearance _colors;

  @override
  AppAppearance get colors {
    if (_colors == null) {
      _calculateColors();
    }
    return _colors;
  }
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
