import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/timetable/w_date_header.dart';
import 'package:volsu_app_v1/features/timetable/w_timetable_companion.dart';
import 'package:volsu_app_v1/providers/timetable_provider.dart';
import 'package:volsu_app_v1/storage/lesson_model.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

import '../../architecture_generics.dart';
import 'w_lesson_item.dart';
import 'w_no_lessons.dart';
import 'w_timetable_break.dart';

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

  DateTime _dateToLoad = DateTime.now();
  List<Widget> _timetableWidgets = [];

  Widget _buildTimetableItem(int pos) {
    if (pos >= _timetableWidgets.length) {
      final timetableProvider = Provider.of<TimetableProvider>(context, listen: false);
      final theme = Provider.of<AppTheme>(context, listen: false);

      List<LessonModel> dayLessons = timetableProvider.getLessonsForDay(_dateToLoad);
      _timetableWidgets.add(DateHeader(_dateToLoad));
      if (dayLessons.isEmpty) {
        _timetableWidgets.add(NoLessons());
      } else {
        for (int i = 0; i < dayLessons.length; i++) {
          _timetableWidgets.add(
            LessonItem(
              lessonModel: dayLessons[i],
              date: _dateToLoad,
              onTap: null,
            ),
          );

          if (i != dayLessons.length - 1) {
            final minCur = dayLessons[i].endTime.hour * 60 + dayLessons[i].endTime.minute;
            final minNext =
                dayLessons[i + 1].startTime.hour * 60 + dayLessons[i + 1].startTime.minute;

            if (minNext - minCur > 20) {
              final h = (minNext - minCur) ~/ 60;
              final m = (minNext - minCur) % 60;
              _timetableWidgets.add(TimetableBreak("Перерыв $hч $mмин"));
            } else {
              _timetableWidgets.add(
                // My divider
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: theme.colors.divider[100],
                  ),
                ),
              );
            }
          }
        }
      }
      _dateToLoad = _dateToLoad.add(Duration(days: 1));
    }
    return _timetableWidgets[pos];
  }
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
    final timetableProvider = Provider.of<TimetableProvider>(context);
    return SafeArea(
      child: timetableProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (ctx, pos) => state._buildTimetableItem(pos),
              padding: EdgeInsets.all(0),
            ),
    );
  }
}
