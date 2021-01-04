import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volsu_app_v1/exceptions/LogicExceptions.dart';
import 'package:volsu_app_v1/exceptions/NetworkExceptions.dart';
import 'package:volsu_app_v1/models/UserCredentials.dart';
import 'package:volsu_app_v1/network/DanielApi.dart';

class AuthProvider extends ChangeNotifier {
  // String _token;
  // String get token => _token;
  //
  // String _email;
  // String get email => _email;

  UserCredentials _userCredentials;

  bool get isAuth => _userCredentials != null;
  String get token => _userCredentials.token;

  void logout() {
    _userCredentials = null;
    notifyListeners();
  }

  Future<void> requestPassCodeForEmail(String email) async {
    Response<dynamic> response;
    try {
      response = await DanielApi.instance.requestPassCode(email);

      if (response.statusCode >= 400) {
        throw EmailIsNotInWhiteList(email);
      }
    } on ConnectionFailure catch (e) {
      throw ConnectionFailure("");
    }
  }

  Future<void> authWithCode(String email, String code) async {
    Response<dynamic> response;
    try {
      response = await DanielApi.instance.authWithCode(email, code);
      if (response.statusCode >= 400) {
        throw InvalidPassCode("");
      }
      _userCredentials = UserCredentials(
        email: email,
        token: (response.data)['access_token'] as String,
      );
      notifyListeners();
    } on ConnectionFailure catch (e) {
      throw ConnectionFailure("");
    }
  }

  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(step1Email, email);
    print("Email cached: $email");
  }

  Future<void> clearSavedEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(step1Email);
    print("Email cached: clear");
  }

  static const step1Email = "step1email";
  Future<String> isEmailSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(step1Email)) {
      print("Email cached: clear: didn't find");
      return null;
    } else {
      final email = prefs.getString(step1Email);
      print("Email cached: saved $email");
      return email;
    }
  }
}
