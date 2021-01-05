import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HomeScreen"),
        ),
        body: FlatButton(
          child: Text("Log out"),
          onPressed: () {
            final auth = Provider.of<AuthProvider>(context, listen: false);
            auth.logout();
          },
        ));
  }
}
