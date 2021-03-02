import 'package:flutter/material.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/features/_globals/w_work_in_progress.dart';

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

  Widget _buildBody() {
    return Center(
      child: Text("Rating"),
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
