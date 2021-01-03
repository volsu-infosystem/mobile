import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';

import 'themes/AppTheme.dart';
import 'features/auth/Auth.dart';
import 'features/home/sHome.dart';
import 'themes/AppTheme.dart';

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
  @override
  Widget build(BuildContext context) {
    print("main rebuild");
    final auth = context.watch<AuthProvider>();
    final appTheme = Provider.of<AppTheme>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme.theme,
      home: auth.isAuth ? HomeScreen() : AuthScreen(),
    );
  }
}
