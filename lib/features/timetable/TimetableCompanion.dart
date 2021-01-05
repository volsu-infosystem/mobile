import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

class TimetableCompanion extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Function action;

  TimetableCompanion({
    @required this.label,
    @required this.color,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    const radius = 14.0;
    return InkWell(
      onTap: action,
      hoverColor: theme.colors.splashOnBackground,
      highlightColor: theme.colors.splashOnBackground,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: theme.colors.inputBorders[100],
            ),
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              if (action != null)
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: theme.colors.inputBorders[700],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
