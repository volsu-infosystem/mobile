import 'package:flutter/material.dart';
import 'package:volsu_app_v1/storage/LessonModel.dart';
import 'package:volsu_app_v1/utils/extensions.dart';

class TimetableProvider with ChangeNotifier {
  List<LessonModel> _lessons;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  TimetableProvider() {
    if (shouldFetch()) {
      forceUpdate();
    } else {
      _lessons = _getFromLocal();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> forceUpdate() async {
    _lessons = await _getFromNetwork();
    _isLoading = false;
    notifyListeners();
    _cacheLessons(_lessons);
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

  bool _isLessonsSavedLocally() {
    // TODO: Is lessons saved in DB?
    return false;
  }

  Future<List<LessonModel>> _getFromNetwork() async {
    // TODO: Get lessons from network
    return Future.delayed(
      Duration(milliseconds: 1500),
      () => [
        LessonModel(
          name: "Матемаический анализ",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Лекция",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 8, minute: 30),
          endTime: TimeOfDay(hour: 10, minute: 00),
          weekday: DateTime.monday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Информатика и программирование",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 10, minute: 10),
          endTime: TimeOfDay(hour: 11, minute: 40),
          weekday: DateTime.monday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Матемаический анализ",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Лекция",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 8, minute: 30),
          endTime: TimeOfDay(hour: 10, minute: 00),
          weekday: DateTime.tuesday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Информатика и программирование",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 10, minute: 10),
          endTime: TimeOfDay(hour: 11, minute: 40),
          weekday: DateTime.tuesday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Информатика и программирование",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 10, minute: 10),
          endTime: TimeOfDay(hour: 11, minute: 40),
          weekday: DateTime.tuesday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Матемаический анализ",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Лекция",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 8, minute: 30),
          endTime: TimeOfDay(hour: 10, minute: 00),
          weekday: DateTime.wednesday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Числительная техника",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 10, minute: 10),
          endTime: TimeOfDay(hour: 11, minute: 40),
          weekday: DateTime.wednesday,
          periodicity: LessonPeriodicity.chis,
        ),
        LessonModel(
          name: "Информатика и программирование",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 13, minute: 40),
          endTime: TimeOfDay(hour: 15, minute: 10),
          weekday: DateTime.wednesday,
          periodicity: LessonPeriodicity.always,
        ),
        // thursday is no lessons
        LessonModel(
          name: "Информатика и программирование",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 10, minute: 10),
          endTime: TimeOfDay(hour: 11, minute: 40),
          weekday: DateTime.friday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Информатика и программирование",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 8, minute: 30),
          endTime: TimeOfDay(hour: 10, minute: 00),
          weekday: DateTime.saturday,
          periodicity: LessonPeriodicity.always,
        ),
        // sunday is weekend
      ],
    );
  }

  bool shouldFetch() {
    if (!_isLessonsSavedLocally()) return true;
    // TODO: Сделать легковесный запрос на сервер: "обновилось ли расписание?"
    return true;
  }

  List<LessonModel> _getFromLocal() {
    // TODO: Get from DB
  }

  void _cacheLessons(List<LessonModel> lessons) {
    // TODO: Save to DB
  }
}
