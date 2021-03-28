import 'package:json_annotation/json_annotation.dart';

part 'base_timetable.g.dart';

enum LessonPeriodicity { always, chis, znam }

@JsonSerializable()
class BaseLesson {
  final String disciplineName;
  final String teacherName;
  final String location;
  final String type;
  final int startTimeHour;
  final int startTimeMin;
  final int endTimeHour;
  final int endTimeMin;
  final int weekday;
  final LessonPeriodicity periodicity;

  BaseLesson({
    this.disciplineName,
    this.teacherName,
    this.location,
    this.type,
    this.startTimeHour,
    this.startTimeMin,
    this.endTimeHour,
    this.endTimeMin,
    this.weekday,
    this.periodicity,
  });

  factory BaseLesson.fromJson(Map<String, dynamic> json) => _$BaseLessonFromJson(json);
  Map<String, dynamic> toJson() => _$BaseLessonToJson(this);
}

@JsonSerializable()
class BaseTimetable {
  List<BaseLesson> lessons;
  // TODO: Учитывать семестр тут
  BaseTimetable(this.lessons);

  factory BaseTimetable.fromJson(Map<String, dynamic> json) => _$BaseTimetableFromJson(json);
  Map<String, dynamic> toJson() => _$BaseTimetableToJson(this);
}
