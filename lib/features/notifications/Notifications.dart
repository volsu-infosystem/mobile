import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Notifications"),
    );
  }
}
