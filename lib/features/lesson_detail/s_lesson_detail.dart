import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/features/lesson_detail/w_lesson_info.dart';
import 'package:volsu_app_v1/models/lesson_model.dart';
import 'package:volsu_app_v1/models/timetable.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';
import 'package:intl/intl.dart';

class LessonDetailScreen extends StatefulWidget {
  @override
  _LessonDetailController createState() => _LessonDetailController();

  final ExactLesson lesson;

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
        label: widget.lesson.location,
      ),
      LessonInfo(
        icon: Icons.school_rounded,
        label: widget.lesson.teacherName,
      ),
    ];
  }

  Widget _buildBody(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    var dayweek;
    switch (widget.lesson.weekday) {
      case 1:
        dayweek = "понедельник";
        break;
      case 2:
        dayweek = "вторник";
        break;
      case 3:
        dayweek = "среда";
        break;
      case 4:
        dayweek = "четверг";
        break;
      case 5:
        dayweek = "пятница";
        break;
      case 6:
        dayweek = "суббота";
        break;
      case 7:
        dayweek = "воскресенье";
        break;
      default:
        dayweek = "[ошибка]";
        break;
    }

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
          widget.lesson.disciplineName,
          style: TextStyle(
            fontFamily: montserrat,
            fontWeight: semibold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        Text(
          DateFormat('d MMMM, E\nHH:mm').format(widget.lesson.exactStart) +
              " — " +
              DateFormat('HH:mm').format(widget.lesson.exactEnd),
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
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          // Create notification
          width: double.infinity,
          height: 45,
          child: RaisedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.map_rounded),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Показать аудиторию на карте",
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
            elevation: 3,
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
            elevation: 3,
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
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: theme.colors.iconOnBackground,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(child: Container()),
                IconButton(
                  icon: Icon(
                    Icons.share_rounded,
                    color: theme.colors.iconOnBackground,
                  ),
                  onPressed: () {
                    // TODO Share
                  },
                ),
              ],
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
