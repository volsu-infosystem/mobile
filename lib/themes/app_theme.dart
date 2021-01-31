import 'package:flutter/material.dart';
import 'package:volsu_app_v1/themes/colors.dart';

enum ColorStyle { light, dark }

const opensans = "Open Sans";
const montserrat = "Montserrat";

const regular = FontWeight.w400;
const semibold = FontWeight.w600;
const bold = FontWeight.w700;

class AppTheme with ChangeNotifier {
  final BuildContext context;

  AppTheme(this.context);

  ColorStyle cs = ColorStyle.light;

  static WhiteAppAppearance white = WhiteAppAppearance();

  AppAppearance get colors {
    return white.colors;
    // if (cs == ColorStyle.light) {
    //   return LightAppAppearance().colors;
    // } else {
    //   return DarkAppAppearance().colors;
    // }
  }

  void updateColorStyle(ColorStyle colorStyle) {
    print("updateColorStyle $colorStyle");
    cs = colorStyle;
    notifyListeners();
  }

  /// Тут переоопределяются только глобальные цвета.
  ThemeData get theme {
    return ThemeData(
      fontFamily: opensans,
      primarySwatch: colors.primary,
      backgroundColor: colors.background,
      scaffoldBackgroundColor: colors.background,
    );
  }
}
