import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/plants/plant_list_widget.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';
import 'package:leaf_lore_flutter/features/plants/plant_stream.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PlantMeta>>(
      stream: getPlantsMetaStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return const Text('No plants found');
        }

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
