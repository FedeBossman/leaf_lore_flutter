import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/firebase/home_page_info_service.dart';
import 'package:leaf_lore_flutter/core/widget/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/home/home_page_info_stream.dart';
import 'package:leaf_lore_flutter/features/home/widget/dashboard_row_widget.dart';
import 'package:leaf_lore_flutter/features/home/model/home_page_info.model.dart';
import 'package:leaf_lore_flutter/core/extension/list_extension.dart';
import 'package:leaf_lore_flutter/features/home/widget/goals_row_widget.dart';

class DashboardInfoWidget extends StatefulWidget {
  const DashboardInfoWidget({super.key});

  @override
  State<DashboardInfoWidget> createState() => _DashboardInfoWidgetState();
}

class _DashboardInfoWidgetState extends State<DashboardInfoWidget> {

  @override
  void initState() {
    super.initState();
    updateWeather();
  }

  Future<void> updateWeather() async {
    requestWeatherUpdate();
  }

  @override
  Widget build(BuildContext context) {
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

        var location = [homePageInfo.location?.city, homePageInfo.location?.state]
            .filterNotNull()
            .join(", ");
        var weather = homePageInfo.weather?.temperature ?? '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 8),
                    Text(location, style: const TextStyle(fontSize: 18)),
                    const Spacer(),
                    Text('$weather°C',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
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
                        title: context.loc.dashboardInfo_type,
                        value: homePageInfo.type ?? ''),
                    div,
                    DashboardRowWidget(
                        icon: Icons.work,
                        title: context.loc.dashboardInfo_experience,
                        value: homePageInfo.experience ?? ''),
                    div,
                    DashboardRowWidget(
                        icon: Icons.local_florist,
                        title: context.loc.dashboardInfo_plants,
                        value: '${homePageInfo.plantsCount}'),
                    div,
                    DashboardRowWidget(
                        icon: Icons.flight_takeoff,
                        title: context.loc.dashboardInfo_rank,
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
