import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/features/lesson_detail/s_lesson_detail.dart';
import 'package:volsu_app_v1/features/timetable/w_companions_area.dart';
import 'package:volsu_app_v1/features/timetable/w_date_header.dart';
import 'package:volsu_app_v1/features/timetable/w_lesson_item.dart';
import 'package:volsu_app_v1/features/timetable/w_no_lessons.dart';
import 'package:volsu_app_v1/features/timetable/w_timetable_break.dart';
import 'package:volsu_app_v1/models/timetable.dart';
import 'package:volsu_app_v1/providers/timetable_provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

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

  @override
  void didChangeDependencies() {
    _timetableWidgets = [];
    super.didChangeDependencies();
  }

  DateTime _dateToLoad = DateTime.now();
  List<Widget> _timetableWidgets = [];

  Widget _buildTimetableItem(int pos) {
    if (pos >= _timetableWidgets.length) {
      final timetableProvider = Provider.of<TimetableProvider>(context, listen: false);

      if (pos == 0) {
        _timetableWidgets.add(
          FlatButton(
            onPressed: timetableProvider.forceUpdate,
            child: Text("Обновить #" + (Random().nextInt(99999 - 10000) + 100000).toString()),
          ),
        );
      } else if (pos == 1) {
        _timetableWidgets.add(
          CompanionsArea(),
        );
      } else {
        final theme = Provider.of<AppTheme>(context, listen: false);
        List<ExactLesson> dayLessons = timetableProvider.getLessonsForDay(_dateToLoad);
        _timetableWidgets.add(DateHeader(_dateToLoad));
        if (dayLessons.isEmpty) {
          _timetableWidgets.add(NoLessons());
        } else {
          for (int i = 0; i < dayLessons.length; i++) {
            _timetableWidgets.add(
              LessonItem(
                lesson: dayLessons[i],
                date: _dateToLoad,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LessonDetailScreen(dayLessons[i]),
                    ),
                  );
                },
              ),
            );

            if (i != dayLessons.length - 1) {
              final minCur = dayLessons[i].endTimeHour * 60 + dayLessons[i].endTimeMin;
              final minNext = dayLessons[i + 1].startTimeHour * 60 + dayLessons[i + 1].startTimeMin;

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
