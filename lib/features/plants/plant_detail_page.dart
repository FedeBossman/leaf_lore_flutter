import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/plants/plant_detail_widget.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';
import 'package:leaf_lore_flutter/features/plants/plant_stream.dart';

class PlantDetailPage extends StatelessWidget {
  final PlantMeta plantMeta;

  const PlantDetailPage({super.key, required this.plantMeta});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Plant>(
      stream: getPlantDetailStream(plantMeta.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return const Text("No plant found.");
        }

        var plant = snapshot.data!;

        return PlantDetailWidget(plant: plant);
      }
    );
  }
}
