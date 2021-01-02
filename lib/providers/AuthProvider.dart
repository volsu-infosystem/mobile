import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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
    return DanielApi.instance.requestPassCode(_email);
  }

  Future<void> authWithCode({String email, String code}) async {
    return Future.delayed(Duration(seconds: 1));
    // TODO
  }
}
