import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

class DrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  DrawerItem({
    @required this.label,
    @required this.icon,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 4,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.colors.primary,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(label, style: TextStyle(fontWeight: semibold,),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
