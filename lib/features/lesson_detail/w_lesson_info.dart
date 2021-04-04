import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

enum LessonInfoType { normal, warning }

class LessonInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final LessonInfoType type;

  const LessonInfo({
    Key key,
    @required this.icon,
    @required this.label,
    this.type = LessonInfoType.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: type == LessonInfoType.normal
                ? theme.colors.weakIconOnBackground[100]
                : theme.colors.error,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: opensans,
                fontWeight: semibold,
                color: type == LessonInfoType.normal ? theme.colors.text : theme.colors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
