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

  void updateToken(String token) {
    this._token = token;
    notifyListeners();
  }

  void logout() {
    this._token = null;
    notifyListeners();
  }

  void updateCredentials({String token, String email}) {
    this._token = token;
    this._email = email;
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

      if (response.statusCode >= 400) {
        throw InvalidPassCode("");
      }
    } on ConnectionFailure catch (e) {
      throw ConnectionFailure("");
    }

    // OLD
    // await Future.delayed(Duration(milliseconds: 1500));
    // // TODO: Обращение к серверу
    // if (code == "123456") {
    //   print("ed__ Token is correct");
    //   // TODO: Сохранение токена в sharedPreferences
    //   _token = "x";
    //   _email = email;
    //   notifyListeners();
    //   return;
    // }
    // print("ed__ InvalidPassCode");
    // throw InvalidPassCode("");
  }
}
