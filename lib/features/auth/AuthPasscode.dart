import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/exceptions/LogicExceptions.dart';
import 'package:volsu_app_v1/features/auth/RegistrationProcessProvider.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';

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

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Container(
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
              auth.userCredentials.email,
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
            FlatButton(
              onPressed: state._handleAnotherEmail,
              child: Text("Ввести другой емейл"),
            ),
            state.isLoading
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
      ),
    );
  }
}
