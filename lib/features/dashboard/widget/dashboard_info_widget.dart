import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/extension/list_extension.dart';
import 'package:leaf_lore_flutter/core/extension/text_extension.dart';
import 'package:leaf_lore_flutter/core/firebase/home_page_info_service.dart';
import 'package:leaf_lore_flutter/features/dashboard/model/home_page_info.model.dart';
import 'package:leaf_lore_flutter/shared/presentation/leaf_card.dart';
import 'package:leaf_lore_flutter/shared/presentation/leaf_chip.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class DashboardInfoWidget extends StatefulWidget {
  HomePageInfo homePageInfo;

  DashboardInfoWidget({super.key, required this.homePageInfo});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildWeatherCard(widget.homePageInfo),
        _buildExperienceCard(widget.homePageInfo),
        _buildGoalsCard(widget.homePageInfo),
      ],
    );
  }

  _buildWeatherCard(HomePageInfo homePageInfo) {
    int? weather = homePageInfo.weather?.temperature;
    String? city = homePageInfo.location?.city;
    String? state = homePageInfo.location?.state;

    return LeafCard(
      child: city == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.loc.dashboardInfo_noLocationData,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18.0, color: LeafLoreColors.spaceCadet),
                ),
                const SizedBox(height: 8),
                Text(
                  context.loc.dashboardInfo_noLocationDataSubText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14.0,
                      color: LeafLoreColors.leafGray,
                      fontStyle: FontStyle.italic),
                ),
              ],
            )
          : Row(
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
                    Text(city, style: const TextStyle(fontSize: 24)),
                    if (state != null)
                      Text(state, style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const Spacer(),
                if (weather != null)
                  Text('$weather°C',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
              ],
            ),
    );
  }

  _buildExperienceCard(HomePageInfo homePageInfo) {
    TextStyle rankStyle = const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: LeafLoreColors.tiffanyBlue);

    String? nickname = homePageInfo.nickname;
    String? type = homePageInfo.type;
    String? experience = homePageInfo.experience;
    String typeAndExprience = [type, experience].filterNotNull().join(' - ');
    int plantsCount = homePageInfo.plantsCount;

    List<String> missingDataMessages = [];
    if (nickname == null || typeAndExprience.isEmpty) {
      missingDataMessages
          .add(context.loc.dashboardInfo_missingExperienceDataSubtext);
    }
    if (homePageInfo.plantsCount == 0) {
      missingDataMessages.add(context.loc.dashboardInfo_missingPlantsData);
    }

    return LeafCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (nickname != null)
            Column(
              children: [
                Text(nickname, style: rankStyle),
                const SizedBox(height: 8),
              ],
            ),
          if (typeAndExprience.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                Text(typeAndExprience,
                    style: const TextStyle(
                        fontSize: 18, color: LeafLoreColors.spaceCadet)),
              ],
            ),
          if (plantsCount > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    context.loc.dashboardInfo_plants_under_care(plantsCount),
                    style: const TextStyle(
                        fontSize: 18,
                        color: LeafLoreColors.leafGray,
                        fontStyle: FontStyle.italic),
                    softWrap: true,
                    textAlign: TextAlign.center, // Center-align text
                  ),
                ),
              ],
            ),
          if (missingDataMessages.length < 2) const SizedBox(height: 16),
          if (missingDataMessages.isNotEmpty)
            Column(
              children: [
                Text(
                  context.loc.dashboardInfo_missingExperienceData,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18.0, color: LeafLoreColors.spaceCadet),
                ),
                const SizedBox(height: 8),
                ...missingDataMessages.map((message) => Text('• $message',
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: LeafLoreColors.leafGray,
                        fontStyle: FontStyle.italic)))
              ],
            ),
        ],
      ),
    );
  }

  _buildGoalsCard(HomePageInfo homePageInfo) {
    return LeafCard(
      child: homePageInfo.goals.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.loc.dashboardInfo_missingGoalsData,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18.0, color: LeafLoreColors.spaceCadet),
                ),
                const SizedBox(height: 8),
                Text(context.loc.dashboardInfo_missingGoalsDataSubtext,
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: LeafLoreColors.leafGray,
                        fontStyle: FontStyle.italic))
              ],
            )
          : Column(
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
    );
  }
}
