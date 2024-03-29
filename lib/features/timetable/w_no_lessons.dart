import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

class NoLessons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Занятий нет",
              style: TextStyle(
                color: theme.colors.text,
                fontWeight: semibold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
