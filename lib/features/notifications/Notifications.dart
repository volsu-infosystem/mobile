import 'package:flutter/material.dart';
import 'package:volsu_app_v1/features/_globals/WorkInProgress.dart';

import '../../architecture_generics.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsController createState() => _NotificationsController();
}

/*
************************************************
*
* **********************************************
*/

class _NotificationsController extends State<NotificationsScreen>
    with AutomaticKeepAliveClientMixin<NotificationsScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) => _NotificationsView(this);
}

/*
************************************************
*
* **********************************************
*/

class _NotificationsView
    extends WidgetView<NotificationsScreen, _NotificationsController> {
  _NotificationsView(_NotificationsController state) : super(state);

  Widget _buildBody() {
    return Center(
      child: Text("Notifications"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBody(),
        Align(
          alignment: Alignment.bottomCenter,
          child: WorkInProgress(),
        ),
      ],
    );
  }
}
