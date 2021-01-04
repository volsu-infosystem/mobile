import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:volsu_app_v1/exceptions/LogicExceptions.dart';
import 'package:volsu_app_v1/exceptions/NetworkExceptions.dart';
import 'package:volsu_app_v1/network/DanielApi.dart';

class AuthProvider extends ChangeNotifier {
  String _token;
  String get token => _token;

  String _email;
  String get email => _email;

  bool get isAuth => _token != null;

  void logout() {
    this._token = null;
    this._email = null;
    notifyListeners();
  }

  Future<void> requestPassCodeForEmail(String email) async {
    print("ed__ requestPassCodeForEmail");
    Response<dynamic> response;
    try {
      response = await DanielApi.instance.requestPassCode(email);

      if (response.statusCode >= 400) {
        print("ed__ EmailIsNotInWhiteList ${response.statusCode}");
        throw EmailIsNotInWhiteList("email");
      }
    } on ConnectionFailure catch (e) {
      print("ed__ ConnectionFailure");
      throw ConnectionFailure("");
    }
  }

  Future<void> authWithCode(String email, String code) async {
    print("ed__ authWithCode");
    Response<dynamic> response;
    try {
      response = await DanielApi.instance.authWithCode(email, code);
      // TEST IMPLEMENTATION
      if (code == "123456") {
        _updateCredentials(token: "test_token", email: email);
        return;
      }
      // END OF TEST IMPLEMENTATION
      if (response.statusCode >= 400) {
        throw InvalidPassCode("");
      }
      // TODO: OK
      print(json.decode(response.data));
    } on ConnectionFailure catch (e) {
      throw ConnectionFailure("");
    }
  }

  void _updateCredentials({String token, String email}) {
    this._token = token;
    this._email = email;
    notifyListeners();
  }
}
