import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/storage/lesson_model.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

class LessonDetailScreen extends StatefulWidget {
  @override
  _LessonDetailController createState() => _LessonDetailController();

  final LessonModel lesson;

  LessonDetailScreen(
    this.lesson,
  );
}

/*
************************************************
*
* **********************************************
*/

class _LessonDetailController extends State<LessonDetailScreen> {
  @override
  Widget build(BuildContext context) => _LessonDetailView(this);
}

/*
************************************************
*
* **********************************************
*/

class _LessonDetailView extends WidgetView<LessonDetailScreen, _LessonDetailController> {
  _LessonDetailView(_LessonDetailController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      body: Center(
        child: Text(
          widget.lesson.name,
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
