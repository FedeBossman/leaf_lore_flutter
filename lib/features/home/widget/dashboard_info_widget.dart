import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/extension/text_extension.dart';
import 'package:leaf_lore_flutter/core/firebase/home_page_info_service.dart';
import 'package:leaf_lore_flutter/core/widget/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/home/streams/home_page_info_stream.dart';
import 'package:leaf_lore_flutter/features/home/model/home_page_info.model.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

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

  Widget _buildGoalChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white,
      side: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    const div = Divider();

    const accentColor = LeafLoreColors.tiffanyBlue;
    TextStyle rankStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: LeafLoreColors.tiffanyBlue);

    return StreamHandler<HomePageInfo>(
      stream: getHomePageInfoStream(),
      builder: (BuildContext context, AsyncSnapshot<HomePageInfo> snapshot) {
        // if (!snapshot.hasData) {
        //   return const Text("Chat with Sprout to get started!");
        // }

        // if (snapshot.hasError) {
        //   return Text("Error: ${snapshot.error}");
        // }

        var homePageInfo = snapshot.data!;

        var weather = homePageInfo.weather?.temperature ?? '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(homePageInfo.location?.city ?? '',
                            style: const TextStyle(fontSize: 24)),
                        Text(homePageInfo.location?.state ?? '',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const Spacer(),
                    Text('$weather°C',
                        style: TextStyle(
                            fontSize: 32,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    homePageInfo.nickname != null
                        ? Column(
                            children: [
                              Text(homePageInfo.nickname!, style: rankStyle),
                              const SizedBox(height: 8),
                            ],
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 8),
                        Text(
                            '${homePageInfo.type} - ${homePageInfo.experience}',
                            style: const TextStyle(
                                fontSize: 18, color: LeafLoreColors.leafGray)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 8),
                        Text(
                            context.loc.dashboardInfo_plants_under_care(
                                homePageInfo.plantsCount),
                            style: TextStyle(
                                fontSize: 18,
                                color: LeafLoreColors.leafGray.withOpacity(
                                    0.7), // Lighter color for subtlety
                                fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flag, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 8),
                        Text(context.loc.dashboardInfo_goals,
                            style: const TextStyle(fontSize: 24)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: homePageInfo.goals
                          .map((goal) => _buildGoalChip(
                              goal.toFirstUpperCase(), accentColor))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
