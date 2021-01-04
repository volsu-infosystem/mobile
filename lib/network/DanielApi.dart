import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import '../exceptions/NetworkExceptions.dart';

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

  Future<Response<dynamic>> requestPassCode(String email) async {
    const url = "auth/request";
    Response<dynamic> response;
    try {
      response = await _dio.post(
        url,
        data: json.encode(
          {
            "email": email,
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // statusCode != 2xx && != 304
        // Обработка таких ошибок на стороне бизнес-логики
        return e.response;
      } else {
        // Проблемы с соединением. Ответа от сервера не пришло.
        throw ConnectionFailure(e.message, e);
      }
    }
  }

  Future<Response<dynamic>> authWithCode(String email, String passCode) async {
    const url = "auth/login";
    Response<dynamic> response;
    try {
      response = await _dio.post(
        url,
        data: json.encode(
          {
            "email": email,
            "secretCode": int.parse(passCode),
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      if (e.response != null)
        return e.response;
      else
        throw ConnectionFailure(e.message, e);
    }
  }
}
