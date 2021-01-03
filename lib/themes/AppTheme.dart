import 'package:flutter/material.dart';
import 'package:volsu_app_v1/themes/colors.dart';

import 'styles.dart';

enum ColorStyle { light, dark }

class AppTheme with ChangeNotifier {
  final BuildContext context;
  AppTheme(this.context);
  ColorStyle cs = ColorStyle.light;

  AppAppearance get colors {
    return LightAppAppearance().colors;
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

  /// Тут переоопределяются только цвета.
  /// Стили для шрифтов создаются в отдельном файле, не вставляюстя в ThemeData
  /// и используются как обращение к статическим полям класса
  ThemeData get theme {
    return ThemeData(
      fontFamily: AppTextStyles.opensans,
      primarySwatch: colors.primary,
      backgroundColor: colors.background,
      scaffoldBackgroundColor: colors.background,
    );
  }
}
