import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/widgets/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/home/home_page_info_stream.dart';
import 'package:leaf_lore_flutter/features/home/dashboard_row_widget.dart';
import 'package:leaf_lore_flutter/features/home/home_page_info.model.dart';
import 'package:leaf_lore_flutter/core/extensions/list_extension.dart';
import 'package:leaf_lore_flutter/features/home/goals_row_widget.dart';

class HomePageInfoWidget extends StatelessWidget {
  const HomePageInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String weather = "24°C";
    int plantCount = 4;

    const div = Divider(height: 14, thickness: 1);

    return StreamHandler<HomePageInfo>(
      stream: getHomePageInfoStream(),
      builder:
          (BuildContext context, AsyncSnapshot<HomePageInfo> snapshot) {
        // if (!snapshot.hasData) {
        //   return const Text("Chat with Sprout to get started!");
        // }

        // if (snapshot.hasError) {
        //   return Text("Error: ${snapshot.error}");
        // }

        var homePageInfo = snapshot.data!;

        var location = [homePageInfo.location.city, homePageInfo.location.state]
            .filterNotNull()
            .join(", ");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(location, style: const TextStyle(fontSize: 18)),
                    const Spacer(),
                    Text(weather,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    DashboardRowWidget(
                        icon: Icons.auto_awesome,
                        title: 'Type',
                        value: homePageInfo.type ?? ''),
                    div,
                    DashboardRowWidget(
                        icon: Icons.work,
                        title: 'Experience',
                        value: homePageInfo.experience ?? ''),
                    div,
                    DashboardRowWidget(
                        icon: Icons.local_florist,
                        title: 'Plants',
                        value: '$plantCount'),
                    div,
                    DashboardRowWidget(
                        icon: Icons.flight_takeoff,
                        title: 'Rank',
                        value: homePageInfo.nickname ?? ''),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    GoalsRow(goals: homePageInfo.goals),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
