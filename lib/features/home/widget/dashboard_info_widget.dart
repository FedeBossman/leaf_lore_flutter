import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/extension/text_extension.dart';
import 'package:leaf_lore_flutter/core/firebase/home_page_info_service.dart';
import 'package:leaf_lore_flutter/core/widget/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/home/streams/home_page_info_stream.dart';
import 'package:leaf_lore_flutter/features/home/model/home_page_info.model.dart';
import 'package:leaf_lore_flutter/shared/presentation/leaf_card.dart';
import 'package:leaf_lore_flutter/shared/presentation/leaf_chip.dart';
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

  @override
  Widget build(BuildContext context) {
    TextStyle rankStyle = const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: LeafLoreColors.tiffanyBlue);

    return StreamHandler<HomePageInfo>(
      stream: getHomePageInfoStream(),
      builder: (BuildContext context, AsyncSnapshot<HomePageInfo> snapshot) {
        var homePageInfo = snapshot.data!;

        var weather = homePageInfo.weather?.temperature ?? '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LeafCard(
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
            LeafCard(
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
                      Text('${homePageInfo.type} - ${homePageInfo.experience}',
                          style: const TextStyle(
                              fontSize: 18, color: LeafLoreColors.spaceCadet)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        // Wrap Text widget with Expanded to use available horizontal space
                        child: Text(
                          context.loc.dashboardInfo_plants_under_care(
                              homePageInfo.plantsCount),
                          style: const TextStyle(
                              fontSize: 18,
                              color: LeafLoreColors.leafGray,
                              fontStyle: FontStyle.italic),
                          softWrap: true, // Allow text wrapping
                          textAlign: TextAlign.center, // Center-align text
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            LeafCard(
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
                        .map((goal) => LeafChip(label: goal.toFirstUpperCase()))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
