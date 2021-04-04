import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volsu_app_v1/architecture_generics.dart';
import 'package:volsu_app_v1/features/rating/w_graph.dart';
import 'package:volsu_app_v1/themes/app_theme.dart';

class SubjRating extends StatefulWidget {
  @override
  _SubjRatingController createState() => _SubjRatingController();
}

/*
************************************************
*
* **********************************************
*/

class _SubjRatingController extends State<SubjRating> {
  @override
  Widget build(BuildContext context) => _SubjRatingView(this);

  bool isExpanded = false;

  void switchCollapsing() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}

/*
************************************************
*
* **********************************************
*/

class _SubjRatingView extends WidgetView<SubjRating, _SubjRatingController> {
  _SubjRatingView(_SubjRatingController state) : super(state);

  Iterable<Widget> _buildExpanded(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return [
      Padding(
        padding: const EdgeInsets.only(left: 29),
        child: Text('Зачёт с оценкой'),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Graph(),
      ),
      Row(
        children: [
          Expanded(
            child: Text('Рейтинг в этом предмете'),
          ),
          Text(
            '1 из 23',
            style: TextStyle(fontFamily: montserrat, fontWeight: bold),
          ),
        ],
      ),
      SizedBox(height: 5),
      Row(
        children: [
          Expanded(
            child: Text('Медианное значение'),
          ),
          Text(
            '60',
            style: TextStyle(fontFamily: montserrat, fontWeight: bold),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context, listen: false);
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: state.switchCollapsing,
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    '🔥',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Математический анализ",
                      style: TextStyle(
                        fontWeight: semibold,
                        fontFamily: montserrat,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    '73',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: montserrat,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              if (state.isExpanded) ..._buildExpanded(context),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
