import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/timetable/Timetable.dart';
import 'package:volsu_app_v1/providers/AuthProvider.dart';

import '../../architecture_generics.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeController createState() => _HomeController();
}

/*
************************************************
*
* **********************************************
*/

class _HomeController extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => _HomeView(this);

  final pages = <Widget>[
    TimetableScreen(),
    TimetableScreen(),
    TimetableScreen(),
  ];

  var _curTab = 0;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _curTab);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToPage(int pos) {
    if (pos == 2) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      auth.logout();
    }
    setState(() {
      _curTab = pos;
      _pageController.jumpToPage(_curTab);
    });
  }
}

/*
************************************************
*
* **********************************************
*/

class _HomeView extends WidgetView<HomeScreen, _HomeController> {
  _HomeView(_HomeController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: state._pageController,
          physics: NeverScrollableScrollPhysics(),
          children: state.pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state._curTab,
          onTap: state.goToPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_one_rounded),
              label: 'One',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_two_rounded),
              label: 'Two',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.three_k),
              label: 'Log out',
            ),
          ],
        ));
  }
}
