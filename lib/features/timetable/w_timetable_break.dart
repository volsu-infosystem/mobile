import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

class TimetableBreak extends StatelessWidget {
  final String text;

  const TimetableBreak(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 62,
            height: 1,
            color: theme.colors.divider[100],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(
                color: theme.colors.textWeak[100],
                fontSize: 12,
                fontFamily: opensans,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 1,
              color: theme.colors.divider[100],
            ),
          ),
        ],
      ),
    );
  }
}
