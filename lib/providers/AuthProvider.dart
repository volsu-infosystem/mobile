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
    print("requestPassCodeForEmail");
    if (email == "mosb-192_962941@volsu.ru") {
      return;
    }
    throw EmailIsNotInWhiteList("");
    // TODO: Обращение к серверу
    return DanielApi.instance.requestPassCode(_email);
  }

  Future<void> authWithCode(String email, String code) async {
    await Future.delayed(Duration(seconds: 1));
    if (code == "123456") {
      _token = "x";
      _email = email;
      notifyListeners();
      return;
    }
    throw InvalidPassCode("");
    // TODO: Обращение к серверу
  }
}
