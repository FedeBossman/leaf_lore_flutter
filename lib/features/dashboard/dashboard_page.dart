import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/widget/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/dashboard/model/home_page_info.model.dart';
import 'package:leaf_lore_flutter/features/dashboard/streams/home_page_info_stream.dart';
import 'package:leaf_lore_flutter/features/dashboard/widget/daily_tip_widget.dart';
import 'package:leaf_lore_flutter/features/dashboard/widget/dashboard_info_widget.dart';
import 'package:leaf_lore_flutter/features/dashboard/widget/seasonal_tip_widget.dart';
import 'package:leaf_lore_flutter/shared/presentation/empty_data_placeholder.dart';

class DashboardPage extends StatelessWidget {
  static const String tabIndex = 'DashboardPage';
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamHandler<HomePageInfo?>(
            empty: EmptyDataPlaceholder(
                text: context.loc.dashboardInfo_settingUpUser,
                subText: context.loc.dashboardInfo_pleaseWait,
                loader: true),
            stream: getHomePageInfoStream(),
            builder:
                (BuildContext context, AsyncSnapshot<HomePageInfo?> snapshot) {
              HomePageInfo homePageInfo = snapshot.data!;

              bool isHomePageInfoReady =
                  checkIfHomePageInfoIsReady(homePageInfo);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DashboardInfoWidget(homePageInfo: homePageInfo),
                  const SizedBox(height: 20),
                  if (isHomePageInfoReady) ...[
                    const DailyTipWidget(),
                    const SizedBox(height: 20),
                    const SeasonalTipWidget(),
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  checkIfHomePageInfoIsReady(HomePageInfo homePageInfo) {
    String? nickname = homePageInfo.nickname;
    String? type = homePageInfo.type;
    String? experience = homePageInfo.experience;
    int plantsCount = homePageInfo.plantsCount;

    return nickname != null &&
        (type != null || experience != null) &&
        plantsCount > 0;
  }
}
