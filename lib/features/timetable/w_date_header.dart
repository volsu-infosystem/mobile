import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

class DateHeader extends StatelessWidget {
  final DateTime dateTime;

  DateHeader(this.dateTime);

  String _capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1)}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${_capitalize(DateFormat("EEEE, d MMMM", "ru_RU").format(dateTime))}",
              style: TextStyle(
                color: theme.colors.textWeak[100],
                fontWeight: semibold,
                fontFamily: opensans,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
