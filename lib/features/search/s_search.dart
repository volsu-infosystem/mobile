import 'package:flutter/material.dart';
import 'package:volsu_app_v1/features/_globals/w_work_in_progress.dart';

import '../../architecture_generics.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchController createState() => _SearchController();
}

/*
************************************************
*
* **********************************************
*/

class _SearchController extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) => _SearchView(this);
}

/*
************************************************
*
* **********************************************
*/

class _SearchView extends WidgetView<SearchScreen, _SearchController> {
  _SearchView(_SearchController state) : super(state);

  Widget _buildBody() {
    return Center(
      child: Text("Search"),
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
