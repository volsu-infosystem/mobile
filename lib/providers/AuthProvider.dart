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
  UserCredentials _userCredentials;

  AuthProvider() {
    getUserCredentialsCache().then((value) {
      _userCredentials = value;
      notifyListeners();
    });
  }

  bool get isAuth {
    if (_userCredentials == null) {
      return false;
    }
    return _userCredentials.isReady;
  }

  String get token {
    if (_userCredentials == null) {
      return null;
    }
    return _userCredentials.token;
  }

  UserCredentials get userCredentials => _userCredentials.copy();

  void logout() {
    _userCredentials = null;
    updateUserCredentialsCache();
  }

  /// Запрашивает отправку кода на почту. Если запрос удался,
  /// записывает данный емейл в [_userCredentials] и
  /// обновляет локальное хранилище вызывая [updateUserCredentialsCache()].
  Future<void> requestPassCodeForEmail(String email) async {
    Response<dynamic> response;
    try {
      response = await DanielApi.instance.requestPassCode(email);
      if (response.statusCode >= 400) {
        throw EmailIsNotInWhiteList(email);
      }

      // Success
      _userCredentials = UserCredentials(email: email);
      updateUserCredentialsCache();
    } on ConnectionFailure catch (e) {
      throw ConnectionFailure("");
    }
  }

  /// Производит авторизацию на сервере с данной почтой и кодом. Если
  /// запрос удался, записывает возвращённый токен в [_userCredentials] и
  /// обновляет локальное хранилище вызывая [updateUserCredentialsCache()].
  Future<void> authWithCode(String email, String code) async {
    Response<dynamic> response;
    try {
      response = await DanielApi.instance.authWithCode(email, code);
      if (response.statusCode >= 400) {
        throw InvalidPassCode("");
      }

      // Success
      _userCredentials.token = (response.data)['access_token'] as String;
      updateUserCredentialsCache();
    } on ConnectionFailure catch (e) {
      throw ConnectionFailure("");
    }
  }

  static const sharpref_userCredentials = "sharpref_userCredentials";

  /// Перезаписывает текущую версию [_userCredentials] из оперативной памяти
  /// в локальное хранилище и вызывает notifyListeners();
  Future<void> updateUserCredentialsCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_userCredentials == null) {
      if (prefs.containsKey(sharpref_userCredentials)) {
        prefs.remove(sharpref_userCredentials);
      }
    } else {
      prefs.setString(sharpref_userCredentials, _userCredentials.toJson());
    }
    notifyListeners();
  }

  Future<UserCredentials> getUserCredentialsCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(sharpref_userCredentials)) {
      return null;
    } else {
      return UserCredentials.fromJson(
          prefs.getString(sharpref_userCredentials));
    }
  }

  // static const _step1Email = "step1email";
  // Future<void> saveEmail(String email) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(_step1Email, email);
  //   print("Email cached: $email");
  //   notifyListeners();
  // }
  //
  // Future<void> clearSavedEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove(_step1Email);
  //   print("Email cached: clear");
  //   notifyListeners();
  // }
  //
  // Future<String> getEmailSaved() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey(_step1Email)) {
  //     print("Email cached: clear: didn't find");
  //     return null;
  //   } else {
  //     final email = prefs.getString(_step1Email);
  //     print("Email cached: saved $email");
  //     return email;
  //   }
  // }
  //
  // static const _step2pass = "step2pass";
  // Future<void> passCodeCompleted() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(_step2pass, true);
  //   notifyListeners();
  // }
  //
  // Future<void> clearPassCodeCache() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove(_step2pass);
  //   notifyListeners();
  // }
  //
  // Future<bool> isPassCodeCompleted() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.containsKey(_step2pass);
  // }
}
