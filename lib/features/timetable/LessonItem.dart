import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/_globals/LessonLPMenu.dart';
import 'package:volsu_app_v1/storage/LessonModel.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';
import 'package:volsu_app_v1/utils/CustomPopupMenu.dart';

class LessonItemView extends StatefulWidget {
  final LessonModel lessonModel;
  final Function onTap;

  LessonItemView({
    @required this.lessonModel,
    @required this.onTap,
  });

  @override
  _LessonItemViewState createState() => _LessonItemViewState();
}

class _LessonItemViewState extends State<LessonItemView> with CustomPopupMenu {
  bool isHighlighted = false;
  bool isWarning = false;

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
            if (isWarning)
              Icon(
                Icons.warning_rounded,
                color: theme.colors.error,
                size: 14,
              ),
            if (isWarning) SizedBox(width: 4),
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
      onLongPress: _showPopup,
      onTapDown: storePosition,
      onTap: () {
        print("LessonItem #${widget.lessonModel.name} clicked");
      },
      // TODO: IntrinsicHeight согласно документации дорог в использовании. Нужно посмотреть как это можно оптимизировать, используя другой виджет
      child: IntrinsicHeight(
        child: Card(
          margin: EdgeInsets.all(0),
          color: isHighlighted ? theme.colors.splashOnBackground[50] : theme.colors.background,
          elevation: isHighlighted ? 4 : 0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: _buildTimeArea(context),
                ),
                SizedBox(width: 2),
                VerticalDivider(thickness: 2, color: theme.colors.divider),
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
    );
  }
}
