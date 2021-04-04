import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/features/_globals/w_work_in_progress.dart';
import 'package:volsu_app_v1/features/rating/w_subj_rating.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

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

  Widget _buildBody(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Рейтинг в группе",
                      style: TextStyle(
                        color: theme.colors.textWeak,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '12',
                      style: TextStyle(
                        color: theme.colors.text,
                        fontFamily: montserrat,
                        fontSize: 40,
                        fontWeight: semibold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Сумма баллов",
                      style: TextStyle(
                        color: theme.colors.textWeak,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '228',
                      style: TextStyle(
                        color: theme.colors.text,
                        fontFamily: montserrat,
                        fontWeight: semibold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(color: theme.colors.divider),
              height: 1,
              width: double.infinity),
          SubjRating(),
          Container(
              decoration: BoxDecoration(color: theme.colors.divider),
              height: 1,
              width: double.infinity),
          SubjRating(),
          Container(
              decoration: BoxDecoration(color: theme.colors.divider),
              height: 1,
              width: double.infinity),
          SubjRating(),
          Container(
              decoration: BoxDecoration(color: theme.colors.divider),
              height: 1,
              width: double.infinity),
          SubjRating(),
          Container(
              decoration: BoxDecoration(color: theme.colors.divider),
              height: 1,
              width: double.infinity),
          SubjRating(),
          Container(
              decoration: BoxDecoration(color: theme.colors.divider),
              height: 1,
              width: double.infinity),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBody(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: WorkInProgress(),
        ),
      ],
    );
  }
}
