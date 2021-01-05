import 'package:flutter/material.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

import '../../architecture_generics.dart';

class HomeDrawerScreen extends StatefulWidget {
  @override
  _HomeDrawerController createState() => _HomeDrawerController();
}

/*
************************************************
*
* **********************************************
*/

class _HomeDrawerController extends State<HomeDrawerScreen> {
  @override
  Widget build(BuildContext context) => _HomeDrawerView(this);
}

/*
************************************************
*
* **********************************************
*/

class _HomeDrawerView
    extends WidgetView<HomeDrawerScreen, _HomeDrawerController> {
  _HomeDrawerView(_HomeDrawerController state) : super(state);

  Widget _buildUserArea() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                  "https://randomuser.me/api/portraits/women/9.jpg"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ольга Петрова",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: semibold,
                      ),
                    ),
                    Text(
                      "МОСб-192, зачётка №962941",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [_buildUserArea()],
        ),
      ),
    );
  }
}
