import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/core/widget/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/plants/widget/plant_list_widget.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';
import 'package:leaf_lore_flutter/features/plants/plant_stream.dart';
import 'package:leaf_lore_flutter/shared/presentation/empty_data_placeholder.dart';
import 'package:leaf_lore_flutter/shared/theme/main_app_bar_widget.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamHandler<List<PlantMeta>>(
      stream: getPlantsMetaStream(),
      empty: EmptyDataPlaceholder(
        text: context.loc.plantsPage_emptyText,
        subText: context.loc.plantsPage_emptySubText,
      ),
      builder: (context, snapshot) {
        final plants = snapshot.data!;

        return PlantListWidget(plants: plants);
      },
    );
  }
}


class PlantNavigationWrapper extends StatelessWidget {
  static const String tabIndex = 'PlantsPage';
  const PlantNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MainAppBar(title: context.loc.plantsPage_title),
        body: const PlantsPage(),
      ),
    );
  }
}
