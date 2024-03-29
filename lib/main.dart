import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/auth/w_auth_email.dart';
import 'package:volsu_app_v1/features/auth/w_auth_passcode.dart';
import 'package:volsu_app_v1/features/home/s_home.dart';
import 'package:volsu_app_v1/network/daniel_api.dart';
import 'package:volsu_app_v1/providers/auth_provider.dart';
import 'package:volsu_app_v1/providers/refresher_provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

import 'file:///C:/flutter_projects/volsu_app_v1/lib/providers/logic_exceptions.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => AppTheme(ctx)),
        ChangeNotifierProvider(create: (ctx) => RefresherProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget _getCorrespondingAuthBody(AuthProvider auth) {
    if (auth.isLoading) {
      return Container();
    }
    if (auth.userCredentials == null || !auth.userCredentials.hasCorrectEmail) {
      return AuthEmail();
    } else if (!auth.userCredentials.hasCorrectToken) {
      return AuthPasscode();
    } else if (!auth.userCredentials.hasCorrectSubgroup) {
      // TODO: Во время разработки вход в эту ветку невозможен. В будущем нужно вернуть экран выбора подгруппы ( return AuthSubgroupPickerScreen(); );
    } else {
      // В таком случае вся авторизация пройдена
      // При правильной имплементации, вход в эту ветку невозможен, т.к.
      // все случаи незаполненных данных должны были быть рассмотрены ранее
      throw ThereIsNoWayItCanBeReached(
          "Приложение считает что авторизация невыполнена ([authProvider.isAuth == false], однако в экране построения ошибок не нашлось подходящего экрана для этой ситуации. \nВозможные решения:\n1. Проверить правильность работы authProvider.isAuth\n2. Исследовать, какой случай незаполненного поля не рассмотрен в методе построения авторизационного экрана и добавить его");
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("ru_RU");
    final auth = Provider.of<AuthProvider>(context);
    final appTheme = Provider.of<AppTheme>(context);
    DanielApi.authProvider = auth;
    return MaterialApp(
      title: 'ВолГУ',
      theme: appTheme.theme,
      home: auth.isAuth ? HomeScreen() : _getCorrespondingAuthBody(auth),
    );
  }
}
