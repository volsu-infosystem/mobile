import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/timetable/DateHeader.dart';
import 'package:volsu_app_v1/features/timetable/LessonItem.dart';
import 'package:volsu_app_v1/features/timetable/TimetableCompanion.dart';
import 'package:volsu_app_v1/providers/TimetableProvider.dart';
import 'package:volsu_app_v1/storage/LessonModel.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

import '../../architecture_generics.dart';
import 'NoLessons.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableController createState() => _TimetableController();
}

/*
************************************************
*
* **********************************************
*/

class _TimetableController extends State<TimetableScreen>
    with AutomaticKeepAliveClientMixin<TimetableScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) => _TimetableView(this);

  DateTime _dateToLoad = DateTime.now();
  List<Widget> _timetableWidgets = [];

  Widget _buildTimetableItem(int pos) {
    if (pos >= _timetableWidgets.length) {
      final timetableProvider = Provider.of<TimetableProvider>(context, listen: false);
      List<LessonModel> dayLessons = timetableProvider.getLessonsForDay(_dateToLoad);
      _timetableWidgets.add(DateHeader(_dateToLoad));
      _dateToLoad = _dateToLoad.add(Duration(days: 1));
      if (dayLessons.isEmpty) {
        _timetableWidgets.add(NoLessons());
      } else {
        for (int i = 0; i < dayLessons.length; i++) {
          _timetableWidgets.add(
            LessonItemView(
              name: dayLessons[i].name,
              teacherName: dayLessons[i].teacherName,
              location: dayLessons[i].location,
              type: dayLessons[i].type,
              startTime: dayLessons[i].startTime.hour.toString() +
                  ":" +
                  dayLessons[i].startTime.minute.toString(),
              endTime: dayLessons[i].endTime.hour.toString() +
                  ":" +
                  dayLessons[i].endTime.minute.toString(),
              onTap: null,
            ),
          );
        }
      }
    }

    return _timetableWidgets[pos];
  }
}

/*
************************************************
*
* **********************************************
*/

class _TimetableView extends WidgetView<TimetableScreen, _TimetableController> {
  _TimetableView(_TimetableController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final timetableProvider = Provider.of<TimetableProvider>(context);
    return SafeArea(
      child: timetableProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (ctx, pos) => state._buildTimetableItem(pos),
            ),
    );
  }
}
