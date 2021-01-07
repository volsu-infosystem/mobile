import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/_globals/LessonLPMenu.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';
import 'package:volsu_app_v1/utils/CustomPopupMenu.dart';

class LessonItem extends StatefulWidget {
  final String type;
  final String name;
  final String location;
  final String teacherName;
  final String startTime;
  final String endTime;
  final bool isWarning;
  final Function onTap;

  LessonItem({
    @required this.type,
    @required this.name,
    @required this.location,
    @required this.teacherName,
    @required this.startTime,
    @required this.endTime,
    @required this.onTap,
    this.isWarning = false,
  });

  @override
  _LessonItemState createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> with CustomPopupMenu {
  bool isHighlighted = false;

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
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              widget.startTime,
              style: TextStyle(
                fontSize: 15,
                fontWeight: semibold,
              ),
            ),
          ),
          Text(
            widget.endTime,
            style: TextStyle(
              fontSize: 12,
              color: theme.colors.textWeak,
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
            if (widget.isWarning)
              Icon(
                Icons.warning_rounded,
                color: theme.colors.error,
                size: 14,
              ),
            if (widget.isWarning) SizedBox(width: 4),
            Expanded(
              child: Text(
                widget.type.toUpperCase(),
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
          widget.name,
          style: TextStyle(
            fontFamily: montserrat,
            fontWeight: semibold,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 2),
        Text(widget.location),
        SizedBox(height: 2),
        Text(
          widget.teacherName,
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
        print("LessonItem #${widget.name} clicked");
      },
      // TODO: IntrinsicHeight согласно документации дорог в использование. Нужно посмотреть как это можно оптимизировать, используя другой виджет
      child: IntrinsicHeight(
        child: Card(
          color: isHighlighted
              ? theme.colors.splashOnBackground[50]
              : theme.colors.background,
          elevation: isHighlighted ? 4 : 0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _buildTimeArea(context),
                VerticalDivider(thickness: 1, color: theme.colors.divider),
                Expanded(child: _buildBody(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
