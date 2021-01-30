import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/_globals/LessonLPMenu.dart';
import 'package:volsu_app_v1/storage/LessonModel.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';
import 'package:volsu_app_v1/utils/CustomPopupMenu.dart';

import '../../architecture_generics.dart';
import 'package:volsu_app_v1/utils/extensions.dart';

class LessonItem extends StatefulWidget {
  final LessonModel lessonModel;
  final Function onTap;
  final DateTime date;

  LessonItem({
    @required this.lessonModel,
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
    print("_updateTimeState: " +
        widget.date.toIso8601String() +
        " - " +
        widget.lessonModel.startTime.hour.toString());
    final minsNow = DateTime.now().hour * 60 + DateTime.now().minute;
    setState(() {
      if (widget.date.ordinalDate != DateTime.now().ordinalDate) {
        timeState = LessonItemTimeState.futureNotToday;
      } else if (widget.lessonModel.endTime.mins() < minsNow) {
        timeState = LessonItemTimeState.past;
      } else if (widget.lessonModel.startTime.mins() > minsNow) {
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
      items: [LessonLPMenu()],
    ).then((value) {
      print("showMenu clicked $value");
      setState(() => isHighlighted = false);
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
              widget.lessonModel.startTime.format(context),
              style: TextStyle(
                fontSize: 15,
                fontWeight: semibold,
              ),
            ),
          ),
          Text(
            widget.lessonModel.endTime.format(context),
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
                widget.lessonModel.type.toUpperCase(),
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
          widget.lessonModel.name,
          style: TextStyle(
            fontFamily: montserrat,
            fontWeight: semibold,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 2),
        Text(widget.lessonModel.location),
        SizedBox(height: 2),
        Text(
          widget.lessonModel.teacherName,
          style: TextStyle(
            color: theme.colors.textWeak,
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
      onTap: () {
        print("LessonItem #${widget.lessonModel.name} clicked");
      },
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
