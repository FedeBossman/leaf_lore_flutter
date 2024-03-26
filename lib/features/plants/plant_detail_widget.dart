import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';

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
            Text("Nickname: ${plant.name}"),
            Text("Nickname: ${plant.nickname}"),
            // Text("Start Date: ${plant.startDate}"),
            Text("Care Level: ${plant.careLevel}"),
            Text("Sunlight Requirement: ${plant.sunlightRequirement}"),
            Text("Watering Frequency: ${plant.wateringFrequency}"),
            Text("Fertilization Frequency: ${plant.fertilizationFrequency}"),
            Text("Soil Type: ${plant.soilType}"),
            Text("Pot Size: ${plant.potSize}"),
            Text("Humidity Requirement: ${plant.humidityRequirement}"),
            if (plant.notes != null) Text("Notes: ${plant.notes}"),
          ],
        ),
      );
  }
}
