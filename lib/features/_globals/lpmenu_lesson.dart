import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/models/timetable.dart';
import 'package:volsu_app_v1/models/lesson_model.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

/// LP означает Long Press
class LessonLPMenu extends PopupMenuEntry<int> {
  final ExactLesson lesson;
  final DateTime date;

  LessonLPMenu(
    this.lesson,
    this.date,
  );

  @override
  _LessonLPMenuState createState() => _LessonLPMenuState();

  // height doesn't matter, as long as we are not giving initialValue to showMenu().
  @override
  double get height => 100;

  @override
  bool represents(int value) => false;
}

class _LessonLPMenuState extends State<LessonLPMenu> {
  String getCopyableString() {
    return 'stub';
  }

  Widget _buildItem({
    @required IconData icon,
    @required String label,
    @required int value,
    @required Function onTap,
  }) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return InkWell(
      onTap: () {
        onTap();
        Navigator.of(context).pop(value);
      },
      highlightColor: theme.colors.splashOnBackground,
      splashColor: theme.colors.splashOnBackground,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.colors.iconOnBackground,
              size: 18,
            ),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: theme.colors.text,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            _buildItem(
              icon: Icons.alarm_rounded,
              label: "Уведомить за...",
              value: 1,
              onTap: () {},
            ),
            _buildItem(
              icon: Icons.map_outlined,
              label: "Где аудитория?",
              value: 2,
              onTap: () {},
            ),
            Divider(),
            _buildItem(
              icon: Icons.share_outlined,
              label: "Поделиться",
              value: 3,
              onTap: () {
                // Share.share(getCopyableString());
              },
            ),
            _buildItem(
              icon: Icons.copy_rounded,
              label: "Копировать",
              value: 4,
              onTap: () {
                Clipboard.setData(ClipboardData(text: getCopyableString()));
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text("Скопировано!"),
                // ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
