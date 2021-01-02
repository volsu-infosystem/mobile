import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/exceptions/NetworkExceptions.dart';
import 'package:volsu_app_v1/network/DanielApi.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';

enum AuthStep {
  inputEmail,
  inputCode,
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthController createState() => _AuthController();
}

/*
************************************************
*
* **********************************************
*/

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
    print("_handleEmailEntered");
    setState(() => isEmailFormLoading = true);
    if (_formEmailKey.currentState.validate()) {
      _formEmailKey.currentState.save();
      final auth = Provider.of<AuthProvider>(context, listen: false);

      try {
        final response = await auth.requestPassCodeForEmail(_email);
        setState(() {
          _authStep = AuthStep.inputCode;
        });
      } on EmailNotAllowed catch (e) {
        setState(() {
          errorMsg = "Данный email пока не подключён к системе";
        });
      } catch (e) {
        setState(() {
          errorMsg = e.toString();
        });
      }
    }
    setState(() => isEmailFormLoading = false);
  }

  void _handlePassCodeEntered() {}

  String _validateEmail(String value) {
    if (!value.contains("@")) {
      return "Введите адрес эл. почты";
    }
    if (!value.endsWith("@volsu.ru")) {
      return "Почта должна быть на домене @volsu.ru";
    }
    return null;
  }

  String _validatePassCode(String value) {
    if (value.length != 6) {
      return "Код неверный";
    }
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
      body = _buildBodyEmail();
    } else {
      body = _buildBodyCode();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("AuthScreen"),
      ),
      body: body,
    );
  }

  Widget _buildErrorMessage() {
    return state.errorMsg == null
        ? null
        : Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              state.errorMsg.toString(),
              style: TextStyle(color: Colors.red),
            ),
          );
  }

  Widget _buildBodyEmail() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 44),
          Text(
            "Привет, студент!",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 54),
          Text(
            "Введи свою почту на домене @volsu.ru,\nчтобы авторизоваться",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14),
          Form(
            key: state._formEmailKey,
            child: TextFormField(
              // Email
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => state._email = value,
              validator: state._validateEmail,
            ),
          ),
          _buildErrorMessage(),
          SizedBox(height: 14),
          state.isEmailFormLoading
              ? Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : RaisedButton(
                  onPressed: state._handleEmailEntered,
                  child: Text("Далее"),
                )
        ],
      ),
    );
  }

  Widget _buildBodyCode() {
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
            "Введи шестизначный код, который мы отправили на почту",
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
          SizedBox(height: 14),
          RaisedButton(
            onPressed: state._handlePassCodeEntered,
            child: Text("Далее"),
          ),
        ],
      ),
    );
  }
}
