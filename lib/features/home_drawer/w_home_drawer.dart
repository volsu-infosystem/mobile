import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/providers/auth_provider.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

import '../../architecture_generics.dart';
import 'w_drawer_item.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerController createState() => _HomeDrawerController();
}

/*
************************************************
*
* **********************************************
*/

class _HomeDrawerController extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) => _HomeDrawerView(this);

  var isLogoutDialogShow = false;

  void _onDrawerItemClicked_profile() {}
  void _onDrawerItemClicked_rating() {}
  void _onDrawerItemClicked_timetable() {}
  void _onDrawerItemClicked_navigation() {}
  void _onDrawerItemClicked_mail() {}
  void _onDrawerItemClicked_notifications() {}
  void _onDrawerItemClicked_help() {}
  void _onDrawerItemClicked_settings() {}
  void _onDrawerItemClicked_logout() {
    setState(() => isLogoutDialogShow = true);
  }

  void _onLogoutDialogClicked_confirm() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.logout();
  }

  void _onLogoutDialogClicked_dismiss() {
    setState(() => isLogoutDialogShow = false);
  }
}

/*
************************************************
*
* **********************************************
*/

class _HomeDrawerView extends WidgetView<HomeDrawer, _HomeDrawerController> {
  _HomeDrawerView(_HomeDrawerController state) : super(state);

  Widget _buildUserArea(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return InkWell(
      onTap: state._onDrawerItemClicked_profile,
      highlightColor: theme.colors.splashOnBackground,
      splashColor: theme.colors.splashOnBackground,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/9.jpg"),
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
          onTap: state._onDrawerItemClicked_rating,
        ),
        DrawerItem(
          label: "Расписание",
          icon: Icons.calendar_view_day_rounded,
          onTap: state._onDrawerItemClicked_timetable,
        ),
        DrawerItem(
          label: "Навигация в вузе",
          icon: Icons.map_outlined,
          onTap: state._onDrawerItemClicked_navigation,
        ),
        DrawerItem(
          label: "Почта",
          icon: Icons.alternate_email_rounded,
          onTap: state._onDrawerItemClicked_mail,
        ),
        DrawerItem(
          label: "Уведомления",
          icon: Icons.notifications_none_rounded,
          onTap: state._onDrawerItemClicked_notifications,
        ),
      ],
    );
  }

  Widget _buildBottomContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DrawerItem(
          label: "Помощь",
          icon: Icons.help_outline_rounded,
          onTap: state._onDrawerItemClicked_help,
        ),
        DrawerItem(
          label: "Настройки",
          icon: Icons.settings_outlined,
          onTap: state._onDrawerItemClicked_settings,
        ),
        if (state.isLogoutDialogShow == false)
          DrawerItem(
            label: "Сменить пользователя",
            icon: Icons.logout,
            onTap: state._onDrawerItemClicked_logout,
          ),
      ],
    );
  }

  Widget _buildLogoutDialog(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          Text(
            "Выйти из аккаунта?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: semibold,
            ),
          ),
          Text(
            "Если захочешь вернуться, тебе снова нужно будет ввести код с почты",
            style: TextStyle(),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlineButton(
                onPressed: state._onLogoutDialogClicked_confirm,
                child: Text(
                  "Выйти",
                ),
                textColor: theme.colors.error,
                highlightedBorderColor: theme.colors.error,
                borderSide: BorderSide(
                  color: theme.colors.error,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FlatButton(
                    hoverColor: theme.colors.splashOnBackground,
                    highlightColor: theme.colors.splashOnBackground,
                    onPressed: state._onLogoutDialogClicked_dismiss,
                    child: Text("Остаться"),
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
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
            _buildUserArea(context),
            Expanded(child: _buildMainContent()),
            SizedBox(height: 42),
            Wrap(children: [_buildBottomContent()]),
            if (state.isLogoutDialogShow) _buildLogoutDialog(context),
          ],
        ),
      ),
    );
  }
}
