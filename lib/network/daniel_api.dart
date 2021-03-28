import 'dart:async';

import 'package:dio/dio.dart';
import 'package:volsu_app_v1/models/timetable.dart';
import 'package:volsu_app_v1/network/daniel_api_responses.dart';
import 'package:volsu_app_v1/network/network_exceptions.dart';
import 'package:volsu_app_v1/providers/auth_provider.dart';

class DanielApi {
  DanielApi._() {
    _dio = Dio();
    _dio.options.baseUrl = "http://64.227.74.131/api/";
    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
  }

  static final _instance = DanielApi._();

  static DanielApi get instance => _instance; // Singleton

  static Dio _dio;

  static AuthProvider authProvider;

  Exception defineError(DioError e, String url) {
    if (e.response != null) {
      return ErrorStatusCode(
          'Error code ($url): ${e.response.statusCode}', e.response.statusCode, e);
    } else {
      return ConnectionFailure('Connection failure ($url)', e);
    }
  }

  Future<bool> requestPassCode(String email) async {
    const url = "auth/request";
    try {
      await _dio.post(
        url,
        data: {
          "email": email,
        },
      );
      return true;
    } on DioError catch (e) {
      throw defineError(e, url);
    }
  }

  Future<AuthLoginResponse> authWithCode(String email, String passCode) async {
    const url = 'auth/login';
    try {
      final response = await _dio.post(
        url,
        data: {
          "email": email,
          "secretCode": int.parse(passCode),
        },
      );
      return AuthLoginResponse(response.data['access_token']);
    } on DioError catch (e) {
      throw defineError(e, url);
    }
  }

  Future<BaseTimetable> getBaseTimetable() async {
    const url = null;
    if (!authProvider.isAuth) {
      throw NotAuthenticated('');
    }

    return Future.delayed(
      Duration(seconds: 1),
      () => BaseTimetable(
        [
          // ПН
          BaseLesson(
            disciplineName: "Физическая культура",
            type: "Практика",
            weekday: 1,
            teacherName: "Цветочкина Галина Ивановна",
            periodicity: LessonPeriodicity.always,
            location: "3-27 В",
            startTimeHour: 10,
            startTimeMin: 10,
            endTimeHour: 11,
            endTimeMin: 40,
          ),
          BaseLesson(
            disciplineName: "Математический анализ",
            type: "Лекция",
            weekday: 1,
            teacherName: "Халтурин Эдуард Рудольфович",
            periodicity: LessonPeriodicity.always,
            location: "4-01 А",
            startTimeHour: 12,
            startTimeMin: 00,
            endTimeHour: 13,
            endTimeMin: 30,
          ),
          // ВТ
          BaseLesson(
            disciplineName: "Алгебра и теория чисел",
            type: "Семинар",
            weekday: 2,
            teacherName: "Ромашкина Ольга Ивановна",
            periodicity: LessonPeriodicity.always,
            location: "4-21 Г",
            startTimeHour: 10,
            startTimeMin: 10,
            endTimeHour: 11,
            endTimeMin: 40,
          ),
          BaseLesson(
            disciplineName: "Дискретная математика",
            type: "Практика",
            weekday: 2,
            teacherName: "Флоришкин Иван Петрович",
            periodicity: LessonPeriodicity.always,
            location: "4-21 Г",
            startTimeHour: 12,
            startTimeMin: 00,
            endTimeHour: 13,
            endTimeMin: 30,
          ),
          BaseLesson(
            disciplineName: "Дискретная математика",
            type: "Лекция",
            weekday: 2,
            teacherName: "Флоришкин Иван Петрович",
            periodicity: LessonPeriodicity.always,
            location: "3-03 В",
            startTimeHour: 13,
            startTimeMin: 30,
            endTimeHour: 15,
            endTimeMin: 10,
          ),
          // СР
          // Выходной
          // ЧТ
          BaseLesson(
            disciplineName: "Экономика",
            type: "Практика",
            weekday: 4,
            teacherName: "Флоришкин Иван Петрович",
            periodicity: LessonPeriodicity.chis,
            location: "Дистанционно",
            startTimeHour: 15,
            startTimeMin: 10,
            endTimeHour: 16,
            endTimeMin: 40,
          ),
          // ПТ
          BaseLesson(
            disciplineName: "Информатика и программирование",
            type: "Практика",
            weekday: 5,
            teacherName: "Тюльпанчик Олег Геннадьевич",
            periodicity: LessonPeriodicity.always,
            location: "2-01 В",
            startTimeHour: 8,
            startTimeMin: 30,
            endTimeHour: 10,
            endTimeMin: 0,
          ),
          BaseLesson(
            disciplineName: "Информатика и программирование",
            type: "Практика",
            weekday: 5,
            teacherName: "Тюльпанчик Олег Геннадьевич",
            periodicity: LessonPeriodicity.znam,
            location: "2-01 В",
            startTimeHour: 10,
            startTimeMin: 10,
            endTimeHour: 11,
            endTimeMin: 40,
          ),
          // СБ
          // Выходной
          // ВС
          // Выходной
        ],
      ),
    );
  }
}
