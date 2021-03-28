import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volsu_app_v1/models/user_credentials.dart';
import 'package:volsu_app_v1/network/daniel_api.dart';
import 'package:volsu_app_v1/network/network_exceptions.dart';
import 'package:volsu_app_v1/providers/logic_exceptions.dart';
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
    try {
      await DanielApi.instance.requestPassCode(email);
      _userCredentials = UserCredentials(email: email);
      _updateUserCredentialsCache();
      notifyListeners();
    } on ConnectionFailure catch (e) {
      throw e;
    } on ErrorStatusCode catch (e) {
      throw EmailIsNotInWhiteList('Email $email is not in white list', e);
    }
  }

  /// Производит авторизацию на сервере с данной почтой и кодом. Если
  /// запрос удался, записывает возвращённый токен в [_userCredentials] и
  /// обновляет локальное хранилище вызывая [updateUserCredentialsCache()].
  Future<void> authWithCode(String email, String code) async {
    try {
      final response = await DanielApi.instance.authWithCode(email, code);
      _userCredentials.token = response.accessToken;
      _updateUserCredentialsCache();
      notifyListeners();
    } on ConnectionFailure {
      throw ConnectionFailure("");
    } on ErrorStatusCode catch (e) {
      if (e.code >= 400) {
        throw InvalidPassCode("Invalid pass code ($code) for email $email", e);
      }
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
