import 'package:flutter/material.dart';
import 'package:volsu_app_v1/themes/AppTheme.dart';

import '../../architecture_generics.dart';
import 'DrawerItem.dart';

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

  Widget _buildMainContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DrawerItem(
          label: "Рейтинг",
          icon: Icons.bar_chart_rounded,
          onTap: () {},
        ),
        DrawerItem(
          label: "Расписание",
          icon: Icons.calendar_view_day_rounded,
          onTap: () {},
        ),
        DrawerItem(
          label: "Навигация в вузе",
          icon: Icons.map_outlined,
          onTap: () {},
        ),
        DrawerItem(
          label: "Почта",
          icon: Icons.alternate_email_rounded,
          onTap: () {},
        ),
        DrawerItem(
          label: "Уведомления",
          icon: Icons.notifications_none_rounded,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildBottomContent() {
    return Padding(
      padding: const EdgeInsets.only(
          right:
              50), // Хоть это выглядит и не красиво, но по UX -- защита от случайных нажатий на опасные кнопки (помощь, настройки, сменить аккаунт)
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DrawerItem(
            label: "Помощь",
            icon: Icons.help_outline_rounded,
            onTap: () {},
          ),
          DrawerItem(
            label: "Настройки",
            icon: Icons.settings_outlined,
            onTap: () {},
          ),
          DrawerItem(
            label: "Сменить пользователя",
            icon: Icons.logout,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _buildUserArea(),
            Expanded(child: _buildMainContent()),
            SizedBox(height: 42),
            Wrap(children: [_buildBottomContent()]),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
