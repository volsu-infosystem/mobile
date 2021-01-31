import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/auth/w_auth_passcode.dart';
import 'package:volsu_app_v1/providers/auth_provider.dart';

import 'exceptions/logic_exceptions.dart';
import 'features/home/s_home.dart';
import 'themes/app_theme.dart';
import 'features/auth/w_auth_email.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => AppTheme(ctx)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget _getCorrespondingAuthBody(AuthProvider auth) {
    if (auth.userCredentials == null || !auth.userCredentials.hasCorrectEmail) {
      return AuthEmail();
    } else if (!auth.userCredentials.hasCorrectToken) {
      return AuthPasscodeScreen();
    } else if (!auth.userCredentials.hasCorrectSubgroup) {
      // TODO: Во время разработки вход в эту ветку невозможен. В будущем нужно вернуть экран выбора подгруппы ( return AuthSubgroupPickerScreen(); );
    } else {
      // В таком случае вся авторизация пройдена
      // При правильной имплементации, вход в эту ветку невозможен, т.к.
      // все случаи незаполненных данных должны были быть рассмотрены ранее
      throw ThereIsNoWayItCanBeReached(
          "Приложение считает что авторизация невыполнена ([authProvider.isAuth == false], однако в экране построения ошибок не нашлось подходящего экрана для этой ситуации. \nВозможные решения:\n1. Проверить правильность работы authProvider.isAuth\n2. Исследовать, какой случай незаполненного поля не рассмотрен в методе построения авторизационного экрана и добавить его");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("ru_RU");
    final auth = Provider.of<AuthProvider>(context);
    final appTheme = Provider.of<AppTheme>(context);
    print("ed__ main rebuild. auth.isAuth=${auth.isAuth}");
    return MaterialApp(
      title: 'ВолГУ',
      theme: appTheme.theme,
      home: auth.isAuth ? HomeScreen() : _getCorrespondingAuthBody(auth),
    );
  }
}
