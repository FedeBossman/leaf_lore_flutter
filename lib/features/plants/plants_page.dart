import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/widgets/stream_handler_widget.dart';
import 'package:leaf_lore_flutter/features/plants/plant_list_widget.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';
import 'package:leaf_lore_flutter/features/plants/plant_stream.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamHandler<List<PlantMeta>>(
      stream: getPlantsMetaStream(),
      builder: (context, snapshot) {
        final plants = snapshot.data!;

        return PlantListWidget(plants: plants);
      },
    );
  }
}


class PlantNavigationWrapper extends StatelessWidget {
  const PlantNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return const PlantsPage();
          },
        );
      },
    );
  }
}
