import 'package:flutter/material.dart';
import 'package:volsu_app_v1/models/timetable.dart';
import 'package:volsu_app_v1/models/lesson_model.dart';
import 'package:volsu_app_v1/network/daniel_api.dart';
import 'package:volsu_app_v1/storage/cache.dart';
import 'package:volsu_app_v1/utils/extensions.dart';

class TimetableProvider with ChangeNotifier {
  BaseTimetable _base;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  TimetableProvider() {
    Cache.instance.isBaseTimetableCached().then((isCached) {
      if (isCached) {
        Cache.instance.getBaseTimetable().then((lessons) {
          _base = lessons;
          _isLoading = false;
          notifyListeners();
        });
      } else {
        DanielApi.instance.getBaseTimetable().then((lessons) {
          _base = lessons;
          _isLoading = false;
          notifyListeners();
          Cache.instance.saveBaseTimetable(_base);
        });
      }
    });
  }

  void forceUpdate() async {
    _isLoading = true;
    notifyListeners();
    DanielApi.instance.getBaseTimetable().then((lessons) {
      _base = lessons;
      _isLoading = false;
      notifyListeners();
      Cache.instance.saveBaseTimetable(_base);
    });
  }

  List<ExactLesson> getLessonsForDay(DateTime dateTime) {
    if (_base == null) {
      return <ExactLesson>[];
    }
    // TODO: Добавить правильный просчёт числительно-знаменательных недель
    // Сейчас чётные недели будут числ, нечётные знам
    LessonPeriodicity curWeekPeriodicity =
        dateTime.week % 2 == 0 ? LessonPeriodicity.chis : LessonPeriodicity.znam;

    return _base.lessons
        .where((BaseLesson lesson) {
          final isPeriodicityMatch = lesson.periodicity == LessonPeriodicity.always ||
              lesson.periodicity == curWeekPeriodicity;
          final isDateMatch = lesson.weekday == dateTime.weekday;
          return isPeriodicityMatch && isDateMatch;
        })
        .toList()
        .map(
          (baseLesson) => ExactLesson.fromBase(
            baseLesson,
            DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
              baseLesson.startTimeHour,
              baseLesson.startTimeMin,
            ),
            DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
              baseLesson.endTimeHour,
              baseLesson.endTimeMin,
            ),
          ),
        )
        .toList();
  }
}
