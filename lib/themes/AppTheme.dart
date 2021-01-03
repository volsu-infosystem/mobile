import 'package:flutter/material.dart';
import 'package:volsu_app_v1/themes/AppColorStyle.dart';
import 'package:volsu_app_v1/themes/LightColorStyle.dart';

enum ColorStyle { light, dark }

class AppTheme with ChangeNotifier {
  /// Переоопределение самых базовых полей, которые затрагивают всё приложение
  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Open Sans',
    );
  }

  static ColorStyle cs = ColorStyle.light;

  static AppColorStyle get colors {
    return LightColorStyle();
  }

  void updateColorStyle(ColorStyle colorStyle) {
    cs = colorStyle;
    notifyListeners();
  }
}
