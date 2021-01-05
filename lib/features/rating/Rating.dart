import 'package:flutter/material.dart';

import '../../architecture_generics.dart';

class RatingScreen extends StatefulWidget {
  @override
  _RatingController createState() => _RatingController();
}

/*
************************************************
*
* **********************************************
*/

class _RatingController extends State<RatingScreen>
    with AutomaticKeepAliveClientMixin<RatingScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) => _RatingView(this);
}

/*
************************************************
*
* **********************************************
*/

class _RatingView extends WidgetView<RatingScreen, _RatingController> {
  _RatingView(_RatingController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Rating"),
    );
  }
}
