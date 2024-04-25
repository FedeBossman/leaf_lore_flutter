import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/home/widget/daily_tip_widget.dart';
import 'package:leaf_lore_flutter/features/home/widget/dashboard_info_widget.dart';
import 'package:leaf_lore_flutter/features/home/widget/seasonal_tip_widget.dart';

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
              DashboardInfoWidget(),
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
