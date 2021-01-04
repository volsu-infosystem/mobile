import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/exceptions/LogicExceptions.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';

import '../../architecture_generics.dart';

class Auth2PassCodeScreen extends StatefulWidget {
  final String _email;
  Auth2PassCodeScreen(this._email);

  @override
  _Auth2PassCodeController createState() => _Auth2PassCodeController();
}

/*
************************************************
*
* **********************************************
*/

class _Auth2PassCodeController extends State<Auth2PassCodeScreen> {
  @override
  Widget build(BuildContext context) => _Auth2PassCodeView(this);

  final _formCodeKey = GlobalKey<FormState>();
  String _passCode;

  String errorMsg;
  bool isPassCodeFormLoading = false;

  void _handlePassCodeEntered() async {
    setState(() {
      errorMsg = null;
      isPassCodeFormLoading = true;
    });

    if (_formCodeKey.currentState.validate()) {
      _formCodeKey.currentState.save();

      final auth = Provider.of<AuthProvider>(context, listen: false);
      try {
        await auth.authWithCode(widget._email, _passCode);
        setState(() {
          // TODO: Go to next screen
        });
      } on InvalidPassCode catch (e) {
        setState(() {
          errorMsg = "Неверный код";
        });
      }
    }
    setState(() => isPassCodeFormLoading = false);
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

class _Auth2PassCodeView
    extends WidgetView<Auth2PassCodeScreen, _Auth2PassCodeController> {
  _Auth2PassCodeView(_Auth2PassCodeController state) : super(state);

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
              state.widget._email,
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
      ),
    );
  }
}
