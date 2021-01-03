import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/exceptions/LogicExceptions.dart';
import 'package:volsu_app_v1/exceptions/NetworkExceptions.dart';
import 'package:volsu_app_v1/network/DanielApi.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';
import 'package:volsu_app_v1/themes/styles.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthController createState() => _AuthController();
}

/*
************************************************
*
* **********************************************
*/

enum AuthStep {
  inputEmail,
  inputCode,
}

class _AuthController extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) => _AuthView(this);

  AuthStep _authStep = AuthStep.inputEmail;
  String _email;
  String _passCode;

  final _formEmailKey = GlobalKey<FormState>();
  final _formCodeKey = GlobalKey<FormState>();

  String errorMsg;
  bool isEmailFormLoading = false;
  bool isPassCodeFormLoading = false;

  void _handleEmailEntered() async {
    setState(() {
      errorMsg = null;
      isEmailFormLoading = true;
    });

    if (_formEmailKey.currentState.validate()) {
      _formEmailKey.currentState.save();

      final auth = Provider.of<AuthProvider>(context, listen: false);
      try {
        await auth.requestPassCodeForEmail(_email);
        // Код выслался без ошибок
        setState(() {
          _authStep = AuthStep.inputCode;
          errorMsg = null;
        });
      } on EmailIsNotInWhiteList catch (e) {
        setState(() {
          errorMsg = "Данный email пока не подключён к системе";
          // TODO Заменить на полноэкранный диалог с возможностью подписаться на рассылку
        });
      } catch (e) {
        setState(() {
          errorMsg = e.toString();
        });
      }
    }
    setState(() => isEmailFormLoading = false);
  }

  void _handlePassCodeEntered() async {
    setState(() {
      errorMsg = null;
      isPassCodeFormLoading = true;
    });

    if (_formCodeKey.currentState.validate()) {
      _formCodeKey.currentState.save();

      final auth = Provider.of<AuthProvider>(context, listen: false);
      try {
        await auth.authWithCode(_email, _passCode);
        setState(() {
          _authStep = AuthStep.inputCode;
        });
      } on InvalidPassCode catch (e) {
        setState(() {
          errorMsg = "Неверный код";
        });
      }
    }
    setState(() => isPassCodeFormLoading = false);
  }

  String _validateEmail(String value) {
    if (!value.contains("@")) {
      return "Введи адрес эл. почты";
    }
    if (!value.endsWith("@volsu.ru")) {
      return "Почта должна быть на домене @volsu.ru";
    }
    return null;
  }

  String _validatePassCode(String value) {
    return null;
  }
}

/*
************************************************
*
* **********************************************
*/

class _AuthView extends WidgetView<AuthScreen, _AuthController> {
  _AuthView(_AuthController state) : super(state);

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (state._authStep == AuthStep.inputEmail) {
      body = _buildBodyEmail(context);
    } else {
      body = _buildBodyCode(context);
    }

    return Scaffold(
      body: body,
    );
  }

  Widget _buildErrorMessage() {
    return state.errorMsg == null
        ? SizedBox(height: 0, width: 0)
        : Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              state.errorMsg.toString(),
              style: TextStyle(color: Colors.red),
            ),
          );
  }

  Widget _buildBodyEmail(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 70),
          Text(
            "Привет, студент!",
            textAlign: TextAlign.center,
            style: AppTextStyles.h1,
          ),
          SizedBox(height: 40),
          Text(
            "Введи свою почту на домене\n@volsu.ru, чтобы авторизоваться",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Form(
            key: state._formEmailKey,
            child: TextFormField(
              // Email
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => state._email = value,
              validator: state._validateEmail,
              style: AppTextStyles.largeInput,
              cursorWidth: 1.2,
              cursorColor: theme.colors.primary,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          _buildErrorMessage(),
          SizedBox(height: 44),
          Container(
            child: state.isEmailFormLoading
                ? Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Container(
                    height: 50,
                    width: 200,
                    child: RaisedButton(
                      onPressed: state._handleEmailEntered,
                      child: Text("Далее"),
                      color: theme.colors.primary,
                      textColor: theme.colors.foregroundOnPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyCode(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 44),
          Text(
            "Подтверди адрес",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 54),
          Text(
            "Введи шестизначный код,\nкоторый мы отправили на почту",
            textAlign: TextAlign.center,
          ),
          Text(
            state._email,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 14),
          Form(
            key: state._formCodeKey,
            child: TextFormField(
              // Code
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, letterSpacing: 6),
              onSaved: (value) => state._passCode = value,
              validator: state._validatePassCode,
            ),
          ),
          _buildErrorMessage(),
          SizedBox(height: 14),
          state.isPassCodeFormLoading
              ? Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : RaisedButton(
                  onPressed: state._handlePassCodeEntered,
                  child: Text("Далее"),
                )
        ],
      ),
    );
  }
}
