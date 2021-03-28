import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:volsu_app_v1/models/lesson_model.dart';
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

  Future<List<LessonModel>> getLessons() async {
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
          location: "4-02 А",
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
          location: "4-03 А",
          type: "Лекция",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 12, minute: 00),
          endTime: TimeOfDay(hour: 13, minute: 30),
          weekday: DateTime.monday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Информатика и программирование",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-04 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 13, minute: 40),
          endTime: TimeOfDay(hour: 15, minute: 10),
          weekday: DateTime.monday,
          periodicity: LessonPeriodicity.always,
        ),
        ////////////////////////////////
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
          location: "4-02 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 12, minute: 00),
          endTime: TimeOfDay(hour: 13, minute: 30),
          weekday: DateTime.tuesday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Информатика и программирование",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-03 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 13, minute: 40),
          endTime: TimeOfDay(hour: 15, minute: 10),
          weekday: DateTime.tuesday,
          periodicity: LessonPeriodicity.always,
        ),
        //////////////////////
        LessonModel(
          name: "Матемаический анализ",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "3-01 А",
          type: "Лекция",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 12, minute: 00),
          endTime: TimeOfDay(hour: 13, minute: 30),
          weekday: DateTime.wednesday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Числительная техника",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "3-02 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 13, minute: 40),
          endTime: TimeOfDay(hour: 15, minute: 10),
          weekday: DateTime.wednesday,
          periodicity: LessonPeriodicity.chis,
        ),
        /////////////////////////// thursday is no lessons
        LessonModel(
          name: "Физическая культура",
          teacherName: "Халтурин Эдуард Рудольфович",
          location: "4-01 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 10, minute: 10),
          endTime: TimeOfDay(hour: 11, minute: 40),
          weekday: DateTime.friday,
          periodicity: LessonPeriodicity.always,
        ),
        ////////////////////////////////////
        LessonModel(
          name: "Педагогика",
          teacherName: "Путин Владимир Владимирович",
          location: "4-01 А",
          type: "Практика",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 8, minute: 30),
          endTime: TimeOfDay(hour: 10, minute: 00),
          weekday: DateTime.saturday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Педагогика",
          teacherName: "Путин Владимир Владимирович",
          location: "4-01 А",
          type: "Лабораторная",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 10, minute: 10),
          endTime: TimeOfDay(hour: 11, minute: 40),
          weekday: DateTime.saturday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Педагогика",
          teacherName: "Путин Владимир Владимирович",
          location: "4-01 А",
          type: "Лабораторная",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 12, minute: 00),
          endTime: TimeOfDay(hour: 13, minute: 30),
          weekday: DateTime.saturday,
          periodicity: LessonPeriodicity.always,
        ),
        LessonModel(
          name: "Педагогика",
          teacherName: "Путин Владимир Владимирович",
          location: "4-01 А",
          type: "Лабораторная",
          importance: LessonImportance.usual,
          startTime: TimeOfDay(hour: 13, minute: 40),
          endTime: TimeOfDay(hour: 15, minute: 10),
          weekday: DateTime.saturday,
          periodicity: LessonPeriodicity.always,
        ),
        // sunday is weekend
      ],
    );
  }
}
