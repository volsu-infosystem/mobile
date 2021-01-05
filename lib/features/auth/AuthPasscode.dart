import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/exceptions/LogicExceptions.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

import '../../architecture_generics.dart';

class AuthPasscodeScreen extends StatefulWidget {
  @override
  _AuthPasscodeController createState() => _AuthPasscodeController();
}

/*
************************************************
*
* **********************************************
*/

class _AuthPasscodeController extends State<AuthPasscodeScreen> {
  @override
  Widget build(BuildContext context) => _AuthPasscodeView(this);

  final _formCodeKey = GlobalKey<FormState>();
  String _passCode;

  String errorMsg;
  bool isLoading = false;

  void _handleAnotherEmail() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.resetEmail();
  }

  void _handlePassCodeEntered() async {
    setState(() {
      errorMsg = null;
      isLoading = true;
    });

    if (_formCodeKey.currentState.validate()) {
      _formCodeKey.currentState.save();

      final auth = Provider.of<AuthProvider>(context, listen: false);
      try {
        await auth.authWithCode(auth.userCredentials.email, _passCode);

        // Success
        setState(() {
          // Сбрасываю стек, чтобы нельзя было вернуться
          Navigator.popUntil(context, ModalRoute.withName('/'));
        });
      } on InvalidPassCode catch (e) {
        setState(() {
          errorMsg = "Неверный код";
        });
      }
    }
    setState(() => isLoading = false);
  }

  String _validatePassCode(String value) {
    if (value == null) {
      return "Введите код";
    }
    if (int.tryParse(value) == null) {
      return "Введите целое число";
    }
    return null;
  }
}

/*
************************************************
*
* **********************************************
*/

class _AuthPasscodeView
    extends WidgetView<AuthPasscodeScreen, _AuthPasscodeController> {
  _AuthPasscodeView(_AuthPasscodeController state) : super(state);

  Widget _buildErrorMessage(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return state.errorMsg == null
        ? SizedBox(height: 0, width: 0)
        : Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              state.errorMsg.toString(),
              style: TextStyle(color: theme.colors.error),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                "Подтверди адрес",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: opensans,
                  fontWeight: semibold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Введи шестизначный код,\nкоторый мы отправили на почту",
                textAlign: TextAlign.center,
              ),
              Text(
                auth.userCredentials.email,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Form(
                key: state._formCodeKey,
                child: TextFormField(
                  // Code
                  keyboardType: TextInputType.number,
                  onSaved: (value) => state._passCode = value,
                  validator: state._validatePassCode,
                  cursorWidth: 1.2,
                  cursorColor: theme.colors.primary,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: montserrat,
                    fontSize: 20,
                    letterSpacing: 5,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    fillColor: theme.colors.inputBorders,
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
              _buildErrorMessage(context),
              SizedBox(height: 20),
              state.isLoading
                  ? Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Container(
                      height: 45,
                      width: 200,
                      child: RaisedButton(
                        onPressed: state._handlePassCodeEntered,
                        child: Text(
                          "Далее",
                          style: TextStyle(
                            fontWeight: semibold,
                          ),
                        ),
                        color: theme.colors.primary,
                        textColor: theme.colors.foregroundOnPrimary,
                        highlightColor: theme.colors.primary[600],
                        splashColor: theme.colors.primary,
                        highlightElevation: 0,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
              SizedBox(height: 15),
              FlatButton(
                onPressed: state._handleAnotherEmail,
                child: Text(
                  "Ввести другой емейл",
                  style: TextStyle(
                    color: theme.colors.primary,
                  ),
                ),
                splashColor: theme.colors.splashOnBackground,
                hoverColor: theme.colors.splashOnBackground,
                highlightColor: theme.colors.splashOnBackground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
