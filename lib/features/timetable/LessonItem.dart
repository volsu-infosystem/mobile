import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

class LessonItem extends StatelessWidget {
  final String type;
  final String name;
  final String location;
  final String teacherName;
  final String startTime;
  final String endTime;
  final bool isWarning;
  final Function onTap;

  @deprecated
  LessonItem({
    @required this.type,
    @required this.name,
    @required this.location,
    @required this.teacherName,
    @required this.startTime,
    @required this.endTime,
    @required this.onTap,
    this.isWarning = false,
  });

  Widget _buildTimeArea(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Container(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              startTime,
              style: TextStyle(
                fontSize: 15,
                fontWeight: semibold,
              ),
            ),
          ),
          Text(
            endTime,
            style: TextStyle(
              fontSize: 12,
              color: theme.colors.textWeak,
            ),
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isWarning)
              Icon(
                Icons.warning_rounded,
                color: theme.colors.error,
                size: 14,
              ),
            if (isWarning) SizedBox(width: 4),
            Expanded(
              child: Text(
                type.toUpperCase(),
                style: TextStyle(
                  color: theme.colors.primary,
                  fontFamily: montserrat,
                  fontWeight: semibold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
        Text(
          name,
          style: TextStyle(
            fontFamily: montserrat,
            fontWeight: semibold,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 2),
        Text(location),
        SizedBox(height: 2),
        Text(
          teacherName,
          style: TextStyle(
            color: theme.colors.textWeak,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    // TODO: IntrinsicHeight согласно документации дорог в использование. Нужно посмотреть как это можно оптимизировать, используя другой виджет
    return IntrinsicHeight(
      child: Row(
        children: [
          _buildTimeArea(context),
          VerticalDivider(thickness: 1, color: theme.colors.divider),
          Expanded(child: _buildBody(context)),
        ],
      ),
    );
  }
}
