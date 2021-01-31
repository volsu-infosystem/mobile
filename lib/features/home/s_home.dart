import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/features/home_drawer/w_home_drawer.dart';
import 'package:volsu_app_v1/features/notifications/s_notifications.dart';
import 'package:volsu_app_v1/features/rating/s_rating.dart';
import 'package:volsu_app_v1/features/search/s_search.dart';
import 'package:volsu_app_v1/features/timetable/s_timetable.dart';
import 'package:volsu_app_v1/providers/auth_provider.dart';
import 'package:volsu_app_v1/providers/timetable_provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

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
    ChangeNotifierProvider(
      create: (ctx) => TimetableProvider(),
      child: TimetableScreen(),
    ),
    RatingScreen(),
    SearchScreen(),
    NotificationsScreen(),
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

  void showMenu(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void goToPage(int pos, BuildContext context) {
    if (pos == 4) {
      showMenu(context);
    } else {
      setState(() {
        _curTab = pos;
        _pageController.jumpToPage(_curTab);
      });
    }
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
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Scaffold(
        body: PageView(
          controller: state._pageController,
          physics: NeverScrollableScrollPhysics(),
          children: state.pages,
        ),
        endDrawer: HomeDrawerScreen(),
        bottomNavigationBar: Builder(
          builder: (context) => BottomNavigationBar(
            backgroundColor: theme.colors.background,
            elevation: 20,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: theme.colors.iconOnBackground_selected,
            unselectedItemColor: theme.colors.iconOnBackground,
            currentIndex: state._curTab,
            onTap: (pos) => state.goToPage(pos, context),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_day_rounded),
                label: 'Расписание',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: 'Рейтинг',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded),
                label: 'Поиск',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_rounded),
                label: 'Уведомления',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_rounded),
                label: 'Меню',
              ),
            ],
          ),
        ));
  }
}
