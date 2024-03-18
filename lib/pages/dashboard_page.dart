import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/widgets/daily_tip_widget.dart';
import 'package:leaf_lore_flutter/widgets/home_page_info_widget.dart';

class DashboardPage extends StatelessWidget {
  @override
Widget build(BuildContext context) {

    return SingleChildScrollView( // Ensures the page is scrollable if content doesn't fit
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HomePageInfoWidget(),
            const SizedBox(height: 20),
            const DailyTipWidget(),
          ],
        ),
      ),
    );
  }
}
