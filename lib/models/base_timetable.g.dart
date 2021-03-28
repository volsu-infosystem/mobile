// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseLesson _$BaseLessonFromJson(Map<String, dynamic> json) {
  return BaseLesson(
    disciplineName: json['disciplineName'] as String,
    teacherName: json['teacherName'] as String,
    location: json['location'] as String,
    type: json['type'] as String,
    startTimeHour: json['startTimeHour'] as int,
    startTimeMin: json['startTimeMin'] as int,
    endTimeHour: json['endTimeHour'] as int,
    endTimeMin: json['endTimeMin'] as int,
    weekday: json['weekday'] as int,
    periodicity:
        _$enumDecodeNullable(_$LessonPeriodicityEnumMap, json['periodicity']),
  );
}

Map<String, dynamic> _$BaseLessonToJson(BaseLesson instance) =>
    <String, dynamic>{
      'disciplineName': instance.disciplineName,
      'teacherName': instance.teacherName,
      'location': instance.location,
      'type': instance.type,
      'startTimeHour': instance.startTimeHour,
      'startTimeMin': instance.startTimeMin,
      'endTimeHour': instance.endTimeHour,
      'endTimeMin': instance.endTimeMin,
      'weekday': instance.weekday,
      'periodicity': _$LessonPeriodicityEnumMap[instance.periodicity],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$LessonPeriodicityEnumMap = {
  LessonPeriodicity.always: 'always',
  LessonPeriodicity.chis: 'chis',
  LessonPeriodicity.znam: 'znam',
};

BaseTimetable _$BaseTimetableFromJson(Map<String, dynamic> json) {
  return BaseTimetable(
    (json['lessons'] as List)
        ?.map((e) =>
            e == null ? null : BaseLesson.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BaseTimetableToJson(BaseTimetable instance) =>
    <String, dynamic>{
      'lessons': instance.lessons,
    };
