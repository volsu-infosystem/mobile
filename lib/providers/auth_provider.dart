import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volsu_app_v1/exceptions/logic_exceptions.dart';
import 'package:volsu_app_v1/exceptions/network_exceptions.dart';
import 'package:volsu_app_v1/models/user_credentials.dart';
import 'package:volsu_app_v1/network/daniel_api.dart';
import 'package:volsu_app_v1/storage/cache.dart';

class AuthProvider extends ChangeNotifier {
  /// За любым обновлением поля у [_userCredentials] **необходимо** вызывать
  /// [_updateUserCredentialsCache()],чтобы в локальном хранилище и оперативной
  /// памяти были одинаковые версии объекта и [notifyListeners()]
  UserCredentials _userCredentials;

  AuthProvider() {
    _getUserCredentialsCache().then((value) {
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

  /// Read only.
  /// Изменения на выданный объект не затронут общего состояния приложения
  UserCredentials get userCredentials {
    if (_userCredentials == null) {
      return null;
    }
    return _userCredentials.copy();
  }

  Future<void> logout() async {
    _userCredentials = null;
    Cache.instance.clearAll();
    _updateUserCredentialsCache();
    notifyListeners();
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
      _updateUserCredentialsCache();
      notifyListeners();
    } on ConnectionFailure {
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
      _updateUserCredentialsCache();
      notifyListeners();
    } on ConnectionFailure {
      throw ConnectionFailure("");
    }
  }

  Future<void> resetEmail() async => logout();

  static const _sharpref_userCredentials = "sharpref_userCredentials";

  /// Перезаписывает текущую версию [_userCredentials] из оперативной памяти
  /// в локальное хранилище в фоновом потоке. Оптимистичная операция.
  Future<void> _updateUserCredentialsCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_userCredentials == null) {
      if (prefs.containsKey(_sharpref_userCredentials)) {
        prefs.remove(_sharpref_userCredentials);
      }
    } else {
      prefs.setString(_sharpref_userCredentials, _userCredentials.toJson());
    }
  }

  Future<UserCredentials> _getUserCredentialsCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_sharpref_userCredentials)) {
      return null;
    } else {
      final uc = UserCredentials.fromJson(prefs.getString(_sharpref_userCredentials));
      return uc;
    }
  }
}
