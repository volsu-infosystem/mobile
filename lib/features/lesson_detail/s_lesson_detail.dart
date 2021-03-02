import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/features/lesson_detail/w_lesson_info.dart';
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

  List<Widget> _buildInfos(BuildContext context) {
    return [
      LessonInfo(
        icon: Icons.warning_rounded,
        label: "Отменена преподавателем",
        type: LessonInfoType.warning,
      ),
      LessonInfo(
        icon: Icons.room_rounded,
        label: "3-01 А",
      ),
      LessonInfo(
        icon: Icons.school_rounded,
        label: "доц. Иванов Иван Иванович",
      ),
    ];
  }

  Widget _buildBody(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          widget.lesson.type.toUpperCase(),
          style: TextStyle(
            color: theme.colors.primary,
            fontFamily: montserrat,
            fontWeight: semibold,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 3),
        Text(
          widget.lesson.name,
          style: TextStyle(
            fontFamily: montserrat,
            fontWeight: semibold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "xx октября, суббота\n10:10 — 11:40",
          style: TextStyle(
            fontWeight: semibold,
          ),
        ),
        SizedBox(height: 20),
        ..._buildInfos(context),
        SizedBox(height: 20),
        Text(
          "КОММЕНТАРИЙ ПРЕПОДАВАТЕЛЯ",
          style: TextStyle(
            fontFamily: montserrat,
            fontWeight: semibold,
            fontSize: 11,
            color: theme.colors.textWeak[200],
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Я приболел, пару проведём в другой день. Напишите мне на почту, что вы думаете об этом",
          style: TextStyle(
            fontWeight: semibold,
            color: theme.colors.text,
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // Create notification
          width: double.infinity,
          height: 45,
          child: RaisedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.notifications_active_rounded),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Создать напоминание",
                    style: TextStyle(
                        // fontWeight: semibold,
                        ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_right_rounded),
              ],
            ),
            color: theme.colors.background,
            textColor: theme.colors.text,
            highlightColor: theme.colors.background[600],
            splashColor: theme.colors.background,
            highlightElevation: 0,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          // Zoom button
          width: double.infinity,
          height: 45,
          child: RaisedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.wifi_tethering_rounded),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Перейти в Zoom",
                    style: TextStyle(
                      fontWeight: semibold,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_right_rounded),
              ],
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: theme.colors.weakIconOnBackground,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: _buildBody(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: _buildActions(context),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
