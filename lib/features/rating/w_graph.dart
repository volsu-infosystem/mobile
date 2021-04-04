import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

class Graph extends StatelessWidget {
  final maxH = 125.0;

  Widget bars(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);

    List<Widget> bars = [];

    final user = new Random().nextInt(20);

    for (int i = 0; i < 20; i++) {
      bars.add(
        Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: user == i ? theme.colors.primary[900] : theme.colors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3),
                topRight: Radius.circular(3),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 1),
            height: maxH * new Random().nextDouble(),
            width: double.infinity,
          ),
        ),
      );
    }

    return Container(
      height: maxH,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: bars,
      ),
    );
  }

  Widget topAxis(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);

    List<Widget> labels = [];

    for (int i = 0; i < 20; i++) {
      String s;
      switch (i) {
        case 0:
          s = '0';
          break;
        case 4:
          s = '20';
          break;
        case 9:
          s = '40';
          break;
        case 12:
          s = '60';
          break;
        case 14:
          s = '71';
          break;
        case 18:
          s = '91';
          break;
        default:
          s = '';
          break;
      }
      labels.add(
        Flexible(
          flex: 1,
          child: Container(
            child: Center(
              child: Text(
                s,
                style: TextStyle(fontSize: 9),
              ),
            ),
            width: double.infinity,
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: labels,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          topAxis(context),
          bars(context),
        ],
      ),
    );
  }
}
