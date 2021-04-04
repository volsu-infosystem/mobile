import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/_globals/lpmenu_lesson.dart';
import 'package:volsu_app_v1/models/timetable.dart';
import 'package:volsu_app_v1/models/lesson_model.dart';
import 'package:volsu_app_v1/providers/refresher_provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';
import 'package:volsu_app_v1/utils/custom_popup_menu.dart';
import 'package:volsu_app_v1/utils/extensions.dart';
import 'package:intl/intl.dart';

import 'package:volsu_app_v1/architecture_generics.dart';

class LessonItem extends StatefulWidget {
  final ExactLesson lesson;
  final Function onTap;
  final DateTime date;

  LessonItem({
    @required this.lesson,
    @required this.date,
    @required this.onTap,
  });

  @override
  _LessonItemController createState() => _LessonItemController();
}

/*
************************************************
*
* **********************************************
*/

enum LessonItemTimeState { past, now, futureToday, futureNotToday }

class _LessonItemController extends State<LessonItem> with CustomPopupMenu {
  @override
  Widget build(BuildContext context) => _LessonItemView(this);

  bool isHighlighted = false;
  bool isWarning = false;
  LessonItemTimeState timeState = LessonItemTimeState.futureNotToday;

  Timer timeStateUpdating;

  @override
  void initState() {
    super.initState();
    _updateTimeState();
    if (timeState == LessonItemTimeState.now || timeState == LessonItemTimeState.futureToday) {
      timeStateUpdating = Timer.periodic(Duration(seconds: 5), (timer) {
        _updateTimeState();
        if (timeState == LessonItemTimeState.past) {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    if (timeStateUpdating?.isActive ?? false) {
      timeStateUpdating.cancel();
    }
    super.dispose();
  }

  void _updateTimeState() {
    final now = DateTime.now();
    setState(() {
      if (widget.date.ordinalDate != DateTime.now().ordinalDate) {
        timeState = LessonItemTimeState.futureNotToday;
      } else if (widget.lesson.exactEnd.isBefore(now)) {
        timeState = LessonItemTimeState.past;
      } else if (widget.lesson.exactStart.isAfter(now)) {
        timeState = LessonItemTimeState.futureToday;
      } else {
        timeState = LessonItemTimeState.now;
      }
    });
  }

  void _showPopup() {
    setState(() => isHighlighted = true);
    this.showMenu(
      color: Colors.transparent,
      elevation: 0,
      context: context,
      items: [LessonLPMenu(widget.lesson, widget.date)],
    ).then((value) {
      setState(() {
        isHighlighted = false;
      });
    });
  }
}

/*
************************************************
*
* **********************************************
*/

class _LessonItemView extends WidgetView<LessonItem, _LessonItemController> {
  _LessonItemView(_LessonItemController state) : super(state);

  Widget _buildTimeArea(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Container(
      width: 52,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              DateFormat('HH:mm').format(widget.lesson.exactStart),
              style: TextStyle(
                fontSize: 15,
                fontWeight: semibold,
                fontFamily: opensans,
              ),
            ),
          ),
          Text(
            DateFormat('HH:mm').format(widget.lesson.exactEnd),
            style: TextStyle(
              fontSize: 11,
              color: theme.colors.textWeak[200],
            ),
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (state.isWarning)
              Icon(
                Icons.warning_rounded,
                color: theme.colors.error,
                size: 14,
              ),
            if (state.isWarning) SizedBox(width: 4),
            Expanded(
              child: Text(
                widget.lesson.type.toUpperCase(),
                style: TextStyle(
                  color: theme.colors.primary,
                  fontFamily: montserrat,
                  fontWeight: semibold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
        Text(
          widget.lesson.disciplineName,
          style: TextStyle(
            fontFamily: montserrat,
            fontWeight: semibold,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 2),
        Text(
          widget.lesson.location,
          style: TextStyle(
            fontFamily: opensans,
          ),
        ),
        SizedBox(height: 2),
        Text(
          widget.lesson.teacherName,
          style: TextStyle(
            color: theme.colors.textWeak,
            fontFamily: opensans,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return GestureDetector(
      onLongPress: state._showPopup,
      onTapDown: state.storePosition,
      onTap: widget.onTap,
      // TODO: IntrinsicHeight согласно документации дорог в использовании. Нужно посмотреть как это можно оптимизировать, используя другой виджет
      child: IntrinsicHeight(
        child: Opacity(
          opacity: state.timeState == LessonItemTimeState.past ? 0.3 : 1.0,
          child: Card(
            margin: EdgeInsets.all(0),
            color:
                state.isHighlighted ? theme.colors.splashOnBackground[50] : theme.colors.background,
            elevation: state.isHighlighted ? 4 : 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: _buildTimeArea(context),
                  ),
                  SizedBox(width: 2),
                  VerticalDivider(
                    thickness: 2,
                    color: state.timeState == LessonItemTimeState.now
                        ? theme.colors.primary
                        : theme.colors.divider,
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: _buildBody(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
