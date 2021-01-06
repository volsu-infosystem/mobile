import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/timetable/LessonItem.dart';
import 'package:volsu_app_v1/features/timetable/TimetableCompanion.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

import '../../architecture_generics.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableController createState() => _TimetableController();
}

/*
************************************************
*
* **********************************************
*/

class _TimetableController extends State<TimetableScreen>
    with AutomaticKeepAliveClientMixin<TimetableScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) => _TimetableView(this);
}

/*
************************************************
*
* **********************************************
*/

class _TimetableView extends WidgetView<TimetableScreen, _TimetableController> {
  _TimetableView(_TimetableController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(height: 12),
            TimetableCompanion(
              label: "Сегодня пары с 10:10 до 15:10",
              icon: Icons.school_rounded,
              color: theme.colors.primary,
              action: () {},
            ),
            SizedBox(height: 12),
            TimetableCompanion(
              label: "Сегодня пар нет",
              icon: Icons.hourglass_empty_rounded,
              color: theme.colors.primary,
            ),
            SizedBox(height: 20),
            LessonItem(
              onTap: null,
              location: "4-21 Г",
              type: "Лекция",
              endTime: "10:00",
              name: "Математический анализ",
              startTime: "08:30",
              teacherName: "Клячин Владимир Александрович",
              isWarning: true,
            ),
            SizedBox(height: 20),
            LessonItem(
              onTap: null,
              location: "4-21 Г",
              type: "Лекция",
              endTime: "10:00",
              name: "Информатика и программирование",
              startTime: "08:30",
              teacherName: "Клячин Владимир Александрович",
            ),
            SizedBox(height: 20),
            LessonItem(
              onTap: null,
              location: "4-21 Г",
              type: "Лекция",
              endTime: "10:00",
              name: "Математический анализ",
              startTime: "08:30",
              teacherName: "Клячин Владимир Александрович",
            ),
            SizedBox(height: 20),
            LessonItem(
              onTap: null,
              location: "4-21 Г",
              type: "Лекция",
              endTime: "10:00",
              name: "Математический анализ",
              startTime: "08:30",
              teacherName: "Клячин Владимир Александрович",
            ),
          ],
        ),
      ),
    );
  }
}
