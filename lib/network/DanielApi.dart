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
  static DanielApi get instance => _instance;

  static Dio _dio;

  Future<dynamic> requestPassCode(String email) async {
    const url = "/auth/request";

    try {
      final response = await _dio.post(
        url,
        data: {
          "email": email,
        },
      );
    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        throw EmailNotAllowed("");
      }
      throw ServerError("requestPassCode");
      // if (e.response != null) {
      //   // response code is not 2xx and is also not 304.
      //
      // } else {
      //   // Something happened in setting up or sending
      //   // the request that triggered an Error
      //   print("ed__ DioError.else catch");
      // }
    }
  }
}
