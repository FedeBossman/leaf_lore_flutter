import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/home/daily_tip_widget.dart';
import 'package:leaf_lore_flutter/features/home/home_page_info_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
Widget build(BuildContext context) {

    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const HomePageInfoWidget(),
              const SizedBox(height: 20),
              DailyTipWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
