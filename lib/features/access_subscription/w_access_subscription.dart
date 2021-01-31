import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

class AccessSubscription extends StatefulWidget {
  final String email;

  const AccessSubscription(this.email);

  @override
  _AccessSubscriptionController createState() => _AccessSubscriptionController();
}

/*
************************************************
*
* **********************************************
*/

class _AccessSubscriptionController extends State<AccessSubscription> {
  @override
  Widget build(BuildContext context) => _AccessSubscriptionView(this);

  String contacts = "";
  final _formContactsKey = GlobalKey<FormState>();

  String _validateContacts(String value) {
    if (value.isEmpty) {
      return "Введи любые контактные данные";
    }
    return null;
  }

  bool isLoading = false;
  bool wasSent = false;

  void _handleBtnClick() async {
    setState(() {
      isLoading = true;
    });
    if (_formContactsKey.currentState.validate()) {
      _formContactsKey.currentState.save();
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        wasSent = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _handleAnotherEmail() {
    Navigator.of(context).pop();
  }
}

/*
************************************************
*
* **********************************************
*/

class _AccessSubscriptionView
    extends WidgetView<AccessSubscription, _AccessSubscriptionController> {
  _AccessSubscriptionView(_AccessSubscriptionController state) : super(state);

  Widget _buildButtonArea(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        left: 15,
        right: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 45,
            child: state.isLoading
                ? Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : Container(
                    child: state.wasSent
                        ? Center(
                            child: Text(
                              "Ты получишь уведомление, когда откроется доступ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: theme.colors.textWeak,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : RaisedButton(
                            onPressed: state._handleBtnClick,
                            child: Text(
                              "Отправить",
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
          SizedBox(height: _paddingBetween / 2),
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
    );
  }

  static const _paddingBetween = 15.0;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 15,
                  left: 15,
                  right: 45,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.colors.text,
                            fontFamily: opensans,
                          ),
                          children: [
                            TextSpan(text: "Емейл "),
                            TextSpan(
                              text: widget.email,
                              style: TextStyle(fontWeight: bold),
                            ),
                            TextSpan(text: " сейчас не поддерживается."),
                          ]),
                    ),
                    SizedBox(height: _paddingBetween),
                    Text(
                      "Это приложение разрабатывается студентами ВолГУ без поддержки со стороны администрации университета. Сейчас оно в пилотной эксплуатации, доступ к нему есть у студентов 1 и 2 курса ИМИТ.",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: _paddingBetween),
                    Text(
                      "После успешного тестового запуска, мы будем постепенно увеличивать аудиторию пользователей у которых есть доступ к приложению.",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: _paddingBetween),
                    Text(
                      "Ты можешь оставить любые свои контактные данные в поле снизу и мы напишем тебе, когда у тебя появится доступ.",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: _paddingBetween),
                    Form(
                      key: state._formContactsKey,
                      child: TextFormField(
                        // Email
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) => state.contacts = value,
                        validator: state._validateContacts,
                        cursorWidth: 1.2,
                        cursorColor: theme.colors.primary,
                        style: TextStyle(
                          fontWeight: semibold,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
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
                  ],
                ),
              ),
              _buildButtonArea(context),
            ],
          ),
        ),
      ),
    );
  }
}
