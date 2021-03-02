import 'package:flutter/material.dart';
import 'package:volsu_app_v1/network/daniel_api.dart';
import 'package:volsu_app_v1/storage/cache.dart';
import 'package:volsu_app_v1/storage/lesson_model.dart';
import 'package:volsu_app_v1/utils/extensions.dart';

class TimetableProvider with ChangeNotifier {
  List<LessonModel> _lessons;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  TimetableProvider() {
    Cache.instance.isLessonsCached().then((isCached) {
      if (isCached) {
        Cache.instance.getLessons().then((lessons) {
          _lessons = lessons;
          _isLoading = false;
          notifyListeners();
        });
      } else {
        DanielApi.instance.getLessons().then((lessons) {
          _lessons = lessons;
          _isLoading = false;
          notifyListeners();
          Cache.instance.saveLessons(_lessons);
        });
      }
    });
  }

  void forceUpdate() async {
    _isLoading = true;
    notifyListeners();
    DanielApi.instance.getLessons().then((lessons) {
      _lessons = lessons;
      _isLoading = false;
      notifyListeners();
      Cache.instance.saveLessons(_lessons);
    });
  }

  List<LessonModel> getLessonsForDay(DateTime dateTime) {
    // TODO: Добавить правильный просчёт числительно-знаменательных недель
    // Сейчас чётные недели будут числ, нечётные знам
    LessonPeriodicity curWeekPeriodicity =
        dateTime.week % 2 == 0 ? LessonPeriodicity.chis : LessonPeriodicity.znam;

    return _lessons.where((LessonModel lesson) {
      final isPeriodicityMatch = lesson.periodicity == LessonPeriodicity.always ||
          lesson.periodicity == curWeekPeriodicity;
      final isDateMatch = lesson.weekday == dateTime.weekday;
      return isPeriodicityMatch && isDateMatch;
    }).toList();
  }
}
