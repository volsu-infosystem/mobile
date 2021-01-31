import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/exceptions/logic_exceptions.dart';
import 'package:volsu_app_v1/features/access_subscription/w_access_subscription.dart';
import 'package:volsu_app_v1/features/auth/w_auth_passcode.dart';
import 'package:volsu_app_v1/providers/auth_provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

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
      setState(
        () {
          errorMsg = " ";
          Navigator.of(context)
              .push(
            MaterialPageRoute(builder: (ctx) => AccessSubscriptionScreen(_email)),
          )
              .then(
            (value) {
              _formEmailKey.currentState.reset();
              setState(
                () {
                  errorMsg = null;
                },
              );
            },
          );
        },
      );
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
            style: TextStyle(
              fontFamily: opensans,
              fontWeight: semibold,
              fontSize: 22,
            ),
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
              onSaved: (value) => state._email = value.toLowerCase(),
              validator: state._validateEmail,
              cursorWidth: 1.2,
              cursorColor: theme.colors.primary,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: semibold,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                fillColor: theme.colors.inputBorders,
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(color: theme.colors.inputBorders),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(color: theme.colors.inputBorders),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(color: theme.colors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(color: theme.colors.error),
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
                    height: 45,
                    width: 200,
                    child: RaisedButton(
                      onPressed: state._handleBtnClick,
                      child: Text(
                        "Далее",
                        style: TextStyle(
                          fontWeight: semibold,
                        ),
                      ),
                      color: theme.colors.primary,
                      textColor: theme.colors.textOnPrimary,
                      highlightColor: theme.colors.primary[600],
                      splashColor: theme.colors.primary,
                      highlightElevation: 0,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
