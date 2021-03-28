import 'package:flutter/material.dart';

const insignificantYear = 1999;

enum LessonImportance { usual, high, special }
enum LessonPeriodicity { always, chis, znam, once }

@deprecated
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
  });

  Map<String, dynamic> toJson() => {
        "name": this.name,
        "teacherName": this.teacherName,
        "location": this.location,
        "type": this.type,
        "importance": this.importance.index,
        "startTime_h": this.startTime.hour,
        "startTime_min": this.startTime.minute,
        "endTime_h": this.endTime.hour,
        "endTime_min": this.endTime.minute,
        "weekday": this.weekday,
        "periodicity": this.periodicity.index,
      };

  LessonModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        teacherName = json["teacherName"],
        location = json["location"],
        type = json["type"],
        importance = LessonImportance.values[json["importance"]],
        startTime = TimeOfDay(hour: json["startTime_h"], minute: json["startTime_min"]),
        endTime = TimeOfDay(hour: json["endTime_h"], minute: json["endTime_min"]),
        weekday = json["weekday"],
        periodicity = LessonPeriodicity.values[json["periodicity"]];
}
