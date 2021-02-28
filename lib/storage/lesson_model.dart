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

  Map<String, dynamic> toJson() => {
        "name": this.name,
        "teacherName": this.teacherName,
        "location": this.location,
        "type": this.type,
        "importance": this.importance.toString(),
        "startTime": this.startTime,
        "endTime": this.endTime,
        "weekday": this.weekday,
        "periodicity": this.periodicity.toString(),
        "exactDate": this.exactDate.microsecondsSinceEpoch,
      };

  LessonModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        teacherName = json["teacherName"],
        location = json["location"],
        type = json["type"],
        importance = json["importance"],
        startTime = json["startTime"],
        endTime = json["endTime"],
        weekday = json["weekday"],
        periodicity = json["periodicity"],
        exactDate = DateTime.fromMicrosecondsSinceEpoch(json["exactDate"]);
}
