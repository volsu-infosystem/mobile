import 'package:flutter/material.dart';

import '../../architecture_generics.dart';

class Auth3SubgroupScreen extends StatefulWidget {
  @override
  _Auth3SubgroupController createState() => _Auth3SubgroupController();
}

/*
************************************************
*
* **********************************************
*/

class _Auth3SubgroupController extends State<Auth3SubgroupScreen> {
  @override
  Widget build(BuildContext context) => _Auth3SubgroupView(this);

  void launchHome() {}
}

/*
************************************************
*
* **********************************************
*/

class _Auth3SubgroupView
    extends WidgetView<Auth3SubgroupScreen, _Auth3SubgroupController> {
  _Auth3SubgroupView(_Auth3SubgroupController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(
        onPressed: state.launchHome,
        child: Text("Go"),
      ),
    );
  }
}
