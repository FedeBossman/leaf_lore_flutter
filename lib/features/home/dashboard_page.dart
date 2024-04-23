import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/home/daily_tip_widget.dart';
import 'package:leaf_lore_flutter/features/home/home_page_info_widget.dart';
import 'package:leaf_lore_flutter/features/home/seasonal_tip_widget.dart';

class DashboardPage extends StatelessWidget {
  static const String tabIndex = 'DashboardPage';
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomePageInfoWidget(),
              SizedBox(height: 20),
              DailyTipWidget(),
              SizedBox(height: 20),
              SeasonalTipWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
