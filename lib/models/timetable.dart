import 'package:json_annotation/json_annotation.dart';

part 'timetable.g.dart';

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

class ExactLesson extends BaseLesson {
  final DateTime exactStart;
  final DateTime exactEnd;

  ExactLesson(
    disciplineName,
    teacherName,
    location,
    type,
    startTimeHour,
    startTimeMin,
    endTimeHour,
    endTimeMin,
    weekday,
    periodicity,
    this.exactStart,
    this.exactEnd,
  ) : super(
          disciplineName: disciplineName,
          teacherName: teacherName,
          location: location,
          type: type,
          startTimeHour: startTimeHour,
          startTimeMin: startTimeMin,
          endTimeHour: endTimeHour,
          endTimeMin: endTimeMin,
          weekday: weekday,
          periodicity: periodicity,
        );

  factory ExactLesson.fromBase(BaseLesson baseLesson, DateTime start, DateTime end) {
    return ExactLesson(
      baseLesson.disciplineName,
      baseLesson.teacherName,
      baseLesson.location,
      baseLesson.type,
      baseLesson.startTimeHour,
      baseLesson.startTimeMin,
      baseLesson.endTimeHour,
      baseLesson.endTimeMin,
      baseLesson.weekday,
      baseLesson.periodicity,
      start,
      end,
    );
  }
}
