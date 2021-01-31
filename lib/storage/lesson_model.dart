import 'package:flutter/material.dart';

enum LessonImportance { usual, high, special }
enum LessonPeriodicity { always, chis, znam, once }

class LessonModel {
  /// Название дисциплины (либо события)
  final String name;

  /// Имя преподавателя
  final String teacherName;

  /// Место проведения
  final String location;

  /// Текстовый тип (лекция, практика, экзамен, ...)
  final String type;

  /// Важность
  final LessonImportance importance;

  /// Время начала.
  final TimeOfDay startTime;

  /// Время окончания события.
  final TimeOfDay endTime;

  /// День недели.
  final int weekday;

  /// Периодичность (всегда, только числ, только знам, однажды). Если указан
  /// параметр [LessonPeriodicity.once], нужно указать [exactDate].
  final LessonPeriodicity periodicity;

  /// Указывается ТОЛЬКО тогда, когда periodicity = once
  final DateTime exactDate;

  LessonModel({
    @required this.name,
    @required this.teacherName,
    @required this.location,
    @required this.type,
    @required this.importance,
    @required this.startTime,
    @required this.endTime,
    @required this.weekday,
    @required this.periodicity,
    this.exactDate,
  });
}
