import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/features/lesson_detail/s_lesson_detail.dart';
import 'package:volsu_app_v1/features/timetable/w_date_header.dart';
import 'package:volsu_app_v1/features/timetable/w_lesson_item.dart';
import 'package:volsu_app_v1/features/timetable/w_no_lessons.dart';
import 'package:volsu_app_v1/features/timetable/w_timetable_break.dart';
import 'package:volsu_app_v1/features/timetable/w_timetable_companion.dart';
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

  DateTime _dateToLoad = DateTime.now();
  List<Widget> _timetableWidgets = [];

  List<TimetableCompanion> _companions = [];

  void _defineCompanions() {
    _companions = [];
    final timetableProvider = Provider.of<TimetableProvider>(context, listen: false);
    final theme = Provider.of<AppTheme>(context, listen: false);
    final now = DateTime.now();
    final todayLessons = timetableProvider.getLessonsForDay(now);

    String f(int n) => n < 10 ? '0$n' : '$n';

    if (todayLessons.isNotEmpty) {
      /// Сегодня есть пары
      int iLessonNow = -1;
      for (int i = 0; i < todayLessons.length; i++) {
        if (now.isAfter(todayLessons[i].exactStart) && now.isBefore(todayLessons[i].exactEnd)) {
          iLessonNow = i;
          break;
        }
      }
      if (now.isBefore(todayLessons.first.exactStart.add(Duration(minutes: 15)))) {
        /// До начала первой пары +15 минут (на опоздания)
        _companions.addAll([
          TimetableCompanion(
            label: 'Сегодня пары с '
                '${todayLessons.first.startTimeHour}:${f(todayLessons.first.startTimeMin)}'
                ' до '
                '${todayLessons.last.endTimeHour}:${f(todayLessons.last.endTimeMin)}',
            color: theme.colors.primary,
            icon: Icons.school_rounded,
          ),
          TimetableCompanion(
            label: 'Первая пара в ${todayLessons.first.location}',
            color: theme.colors.primary,
            icon: Icons.location_on_rounded,
          ),
        ]);
      } else if (now.isAfter(todayLessons.first.exactStart) &&
          now.isBefore(todayLessons.last.exactEnd)) {
        /// Во время учебного времени
        if (iLessonNow == -1) {
          /// Сейчас перемена
          _companions.addAll([
            TimetableCompanion(
              label: 'До начала пары '
                  '${todayLessons[iLessonNow + 1].exactStart.difference(now).inMinutes}'
                  ' минут',
              color: theme.colors.primary,
              icon: Icons.watch_later_rounded,
            ),
            TimetableCompanion(
                label: 'Следующая пара в ${todayLessons[iLessonNow + 1].location}',
                color: theme.colors.primary,
                icon: Icons.location_on_rounded),
          ]);
        } else {
          /// Сейчас идёт пара
          _companions.addAll([
            TimetableCompanion(
              label: 'До конца пары '
                  '${todayLessons[iLessonNow].exactEnd.difference(now).inMinutes}'
                  ' минут',
              color: theme.colors.primary,
              icon: Icons.watch_later_rounded,
            ),
          ]);
          if (now.isAfter(todayLessons[iLessonNow].exactEnd.subtract(Duration(minutes: 15)))) {
            /// До конца пары осталось меньше 15 минут
            _companions.addAll([
              TimetableCompanion(
                label: 'Следующая пара в ${todayLessons[iLessonNow + 1].location}',
                color: theme.colors.primary,
                icon: Icons.location_on_rounded,
              ),
            ]);
          }
        }
      } else {
        /// После учебного времени
        final tomorrowLessons = timetableProvider.getLessonsForDay(now.add(Duration(days: 1)));
        if (tomorrowLessons.isNotEmpty) {
          /// Завтра есть пары
          _companions.addAll([
            TimetableCompanion(
              label: 'Завтра пары с '
                  '${tomorrowLessons.first.startTimeHour}:${f(tomorrowLessons.first.startTimeMin)}'
                  ' до '
                  '${tomorrowLessons.last.endTimeHour}:${f(tomorrowLessons.last.endTimeMin)}',
              color: theme.colors.primary,
              icon: Icons.school_rounded,
            ),
          ]);
        }
      }
    } else {
      /// Сегодня нет пар
      _companions.addAll([
        TimetableCompanion(
          label: 'Сегодня пар нет',
          color: theme.colors.primary,
          icon: Icons.blur_on,
        ),
      ]);
      final tomorrowLessons = timetableProvider.getLessonsForDay(now.add(Duration(days: 1)));
      if (tomorrowLessons.isNotEmpty) {
        /// Завтра есть пары
        _companions.addAll([
          TimetableCompanion(
            label: 'Завтра пары с '
                '${tomorrowLessons.first.startTimeHour}:${f(tomorrowLessons.first.startTimeMin)}'
                ' до '
                '${tomorrowLessons.last.endTimeHour}:${f(tomorrowLessons.last.endTimeMin)}',
            color: theme.colors.primary,
            icon: Icons.school_rounded,
          ),
        ]);
      }
    }
  }

  Widget _buildTimetableItem(int pos) {
    if (pos >= _timetableWidgets.length) {
      final timetableProvider = Provider.of<TimetableProvider>(context, listen: false);

      if (pos == 0) {
        _timetableWidgets.add(
          FlatButton(
            onPressed: timetableProvider.forceUpdate,
            child: Text("Обновить"),
          ),
        );
      } else if (pos <= _companions.length) {
        _timetableWidgets.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: _companions[pos - 1],
          ),
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
    state._defineCompanions();
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
