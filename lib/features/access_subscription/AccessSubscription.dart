import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

import '../../architecture_generics.dart';

class AccessSubscriptionScreen extends StatefulWidget {
  final String email;

  const AccessSubscriptionScreen(this.email);

  @override
  _AccessSubscriptionController createState() =>
      _AccessSubscriptionController();
}

/*
************************************************
*
* **********************************************
*/

class _AccessSubscriptionController extends State<AccessSubscriptionScreen> {
  @override
  Widget build(BuildContext context) => _AccessSubscriptionView(this);

  String contacts = "";

  String _validateContacts(String value) {
    if (value.isEmpty) {
      return "Введи любые контактные данные";
    }
    return null;
  }

  bool isLoading = false;

  void _handleBtnClick() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
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

class _AccessSubscriptionView extends WidgetView<AccessSubscriptionScreen,
    _AccessSubscriptionController> {
  _AccessSubscriptionView(_AccessSubscriptionController state) : super(state);

  @override
  Widget build(BuildContext context) {
    const paddingBetween = 15.0;
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                        color: theme.colors.foreground,
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
                SizedBox(height: paddingBetween),
                Text(
                  "Это приложение разрабатывается студентами ВолГУ без поддержки со стороны администрации университета. Сейчас оно в пилотной эксплуатации, доступ к нему есть у студентов 1 и 2 курса ИМИТ.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: paddingBetween),
                Text(
                  "После успешного тестового запуска, мы будем постепенно увеличивать аудиторию пользователей у которых есть доступ к приложению.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: paddingBetween),
                Text(
                  "Ты можешь оставить любые свои контактные данные в поле снизу и мы напишем тебе, когда у тебя появится доступ.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: paddingBetween),
                TextFormField(
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
                SizedBox(height: paddingBetween),
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
                ),
                SizedBox(height: paddingBetween),
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
      ),
    );
  }
}
