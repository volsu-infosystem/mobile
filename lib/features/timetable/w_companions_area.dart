import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/features/timetable/w_timetable_companion.dart';
import 'package:volsu_app_v1/providers/refresher_provider.dart';
import 'package:volsu_app_v1/providers/timetable_provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';
import 'package:volsu_app_v1/utils/extensions.dart';

class CompanionsArea extends StatefulWidget {
  @override
  CompanionsAreaController createState() => CompanionsAreaController();
}

/*
************************************************
*
* **********************************************
*/

class CompanionsAreaController extends State<CompanionsArea> {
  @override
  Widget build(BuildContext context) => CompanionsAreaView(this);

  List<Widget> companions = [];

  void _addCompanion(TimetableCompanion tc) {
    companions.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: tc,
      ),
    );
  }

  void defineCompanions() {
    companions = [];
    final timetableProvider = Provider.of<TimetableProvider>(context, listen: false);
    final theme = Provider.of<AppTheme>(context, listen: false);
    final now = DateTime.now();
    final todayLessons = timetableProvider.getLessonsForDay(now);

    String f(int n) => n < 10 ? '0$n' : '$n';

    if (todayLessons.isNotEmpty) {
      /// Сегодня есть пары
      int iLessonNow = -1;
      int iLessonCurOrPrev = -1;
      for (int i = 0; i < todayLessons.length; i++) {
        iLessonCurOrPrev++;
        if (now.isAfterOrEq(todayLessons[i].exactStart) &&
            now.isBeforeOrEq(todayLessons[i].exactEnd)) {
          iLessonNow = i;
          break;
        }
      }
      if (now.isBefore(todayLessons.first.exactStart.add(Duration(minutes: 15)))) {
        /// До начала первой пары +15 минут (на опоздания)
        _addCompanion(TimetableCompanion(
          label: 'Сегодня пары с '
              '${todayLessons.first.startTimeHour}:${f(todayLessons.first.startTimeMin)}'
              ' до '
              '${todayLessons.last.endTimeHour}:${f(todayLessons.last.endTimeMin)}',
          color: theme.colors.primary,
          icon: Icons.school_rounded,
        ));
        _addCompanion(TimetableCompanion(
          label: 'Первая пара в ${todayLessons.first.location}',
          color: theme.colors.primary,
          icon: Icons.location_on_rounded,
        ));
      } else if (now.isAfterOrEq(todayLessons.first.exactStart) &&
          now.isBefore(todayLessons.last.exactEnd)) {
        /// Во время учебного времени
        if (iLessonNow == -1) {
          /// Сейчас перемена
          _addCompanion(TimetableCompanion(
            label: 'До начала пары '
                '${(todayLessons[iLessonCurOrPrev].exactStart.difference(now).inMinutes).abs() + 1}'
                ' минут',
            color: theme.colors.primary,
            icon: Icons.watch_later_rounded,
          ));
          _addCompanion(
            TimetableCompanion(
              label: 'Следующая пара в ${todayLessons[iLessonCurOrPrev].location}',
              color: theme.colors.primary,
              icon: Icons.location_on_rounded,
            ),
          );
        } else {
          /// Сейчас идёт пара
          _addCompanion(
            TimetableCompanion(
              label: 'До конца пары '
                  '${todayLessons[iLessonNow].exactEnd.difference(now).inMinutes + 1}'
                  ' минут',
              color: theme.colors.primary,
              icon: Icons.watch_later_rounded,
            ),
          );
          if (now.isAfter(todayLessons[iLessonNow].exactEnd.subtract(Duration(minutes: 15))) &&
              iLessonCurOrPrev < todayLessons.length - 1) {
            /// До конца пары осталось меньше 15 минут и это не последняя пара
            _addCompanion(
              TimetableCompanion(
                label: 'Следующая пара в ${todayLessons[iLessonCurOrPrev + 1].location}',
                color: theme.colors.primary,
                icon: Icons.location_on_rounded,
              ),
            );
          }
        }
      } else {
        /// После учебного времени
        final tomorrowLessons = timetableProvider.getLessonsForDay(now.add(Duration(days: 1)));
        if (tomorrowLessons.isNotEmpty) {
          /// Завтра есть пары
          _addCompanion(
            TimetableCompanion(
              label: 'Завтра пары с '
                  '${tomorrowLessons.first.startTimeHour}:${f(tomorrowLessons.first.startTimeMin)}'
                  ' до '
                  '${tomorrowLessons.last.endTimeHour}:${f(tomorrowLessons.last.endTimeMin)}',
              color: theme.colors.primary,
              icon: Icons.school_rounded,
            ),
          );
        }
      }
    } else {
      /// Сегодня нет пар
      _addCompanion(
        TimetableCompanion(
          label: 'Сегодня пар нет',
          color: theme.colors.primary,
          icon: Icons.blur_on,
        ),
      );
      final tomorrowLessons = timetableProvider.getLessonsForDay(now.add(Duration(days: 1)));
      if (tomorrowLessons.isNotEmpty) {
        /// Завтра есть пары
        _addCompanion(
          TimetableCompanion(
            label: 'Завтра пары с '
                '${tomorrowLessons.first.startTimeHour}:${f(tomorrowLessons.first.startTimeMin)}'
                ' до '
                '${tomorrowLessons.last.endTimeHour}:${f(tomorrowLessons.last.endTimeMin)}',
            color: theme.colors.primary,
            icon: Icons.school_rounded,
          ),
        );
      }
    }
  }
}

/*
************************************************
*
* **********************************************
*/

class CompanionsAreaView extends WidgetView<CompanionsArea, CompanionsAreaController> {
  CompanionsAreaView(CompanionsAreaController state) : super(state);

  @override
  Widget build(BuildContext context) {
    Provider.of<RefresherProvider>(context);
    state.defineCompanions();
    return Center(
      child: Column(
        children: (state.companions),
      ),
    );
  }
}
