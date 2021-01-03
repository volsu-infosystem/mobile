import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';

import 'theme.dart';
import 'features/auth/Auth.dart';
import 'features/home/sHome.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.instance,
      home: auth.isAuth ? HomeScreen() : AuthScreen(),
    );
  }
}
