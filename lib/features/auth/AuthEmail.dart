import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/exceptions/LogicExceptions.dart';
import 'package:volsu_app_v1/features/auth/AuthPasscode.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

class AuthEmail extends StatefulWidget {
  @override
  _AuthEmailController createState() => _AuthEmailController();
}

/*
************************************************
*
* **********************************************
*/

class _AuthEmailController extends State<AuthEmail> {
  @override
  Widget build(BuildContext context) => _AuthEmailView(this);

  String _email;

  final _formEmailKey = GlobalKey<FormState>();

  String errorMsg;
  bool isLoading = false;

  void _handleBtnClick() async {
    setState(() {
      errorMsg = null;
      isLoading = true;
    });

    if (_formEmailKey.currentState.validate()) {
      _formEmailKey.currentState.save();
      await _sendRequest();
    }
    setState(() => isLoading = false);
  }

  Future<void> _sendRequest() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    try {
      await auth.requestPassCodeForEmail(_email);

      // Код выслался без ошибок
      setState(() {
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

  String _validateEmail(String value) {
    if (!value.contains("@")) {
      return "Введи адрес эл. почты";
    }
    if (!value.endsWith("@volsu.ru")) {
      return "Почта должна быть на домене @volsu.ru";
    }
    return null;
  }
}

/*
************************************************
*
* **********************************************
*/

class _AuthEmailView extends WidgetView<AuthEmail, _AuthEmailController> {
  _AuthEmailView(_AuthEmailController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyEmail(context),
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
            child: state.isLoading
                ? Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Container(
                    height: 50,
                    width: 200,
                    child: RaisedButton(
                      onPressed: state._handleBtnClick,
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
}
