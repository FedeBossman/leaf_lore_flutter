import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';
import 'package:leaf_lore_flutter/shared/theme/main_app_bar_widget.dart';

class PlantDetailWidget extends StatelessWidget {
  final Plant plant;

  const PlantDetailWidget({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${context.loc.plantDetail_name}: ${plant.name}"),
          Text("${context.loc.plantDetail_name}: ${plant.nickname}"),
          // Text("Start Date: ${plant.startDate}"),
          Text("${context.loc.plantDetail_careLevel}: ${plant.careLevel}"),
          Text(
              "${context.loc.plantDetail_sunlightRequirement}: ${plant.sunlightRequirement}"),
          Text(
              "${context.loc.plantDetail_wateringFrequency}: ${plant.wateringFrequency}"),
          Text(
              "${context.loc.plantDetail_fertilizationFrequency}: ${plant.fertilizationFrequency}"),
          Text("${context.loc.plantDetail_soilType}: ${plant.soilType}"),
          Text("${context.loc.plantDetail_potSize}: ${plant.potSize}"),
          Text(
              "${context.loc.plantDetail_humidityRequirement}: ${plant.humidityRequirement}"),
          if (plant.notes != null)
            Text("${context.loc.plantDetail_notes}: ${plant.notes}"),
        ],
      ),
    );
  }
}
