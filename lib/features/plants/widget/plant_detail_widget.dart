import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/features/plants/plant_enum.dart';
import 'package:leaf_lore_flutter/features/plants/plant_model.dart';
import 'package:leaf_lore_flutter/shared/presentation/leaf_card.dart';
import 'package:leaf_lore_flutter/shared/presentation/leaf_chip.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class PlantDetailWidget extends StatelessWidget {
  final Plant plant;

  PlantDetailWidget({super.key, required this.plant});

  TextStyle accentStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: LeafLoreColors.tiffanyBlue);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LeafCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      Text('${plant.officialSpeciesName} - ${CareLevel.low.loc(context)}',
                          style: const TextStyle(
                              fontSize: 18, color: LeafLoreColors.spaceCadet)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LeafChip(
                              label: plant.sunlightRequirement.loc(context),
                              icon: Icons.wb_sunny),
                          const SizedBox(height: 8),
                          LeafChip(
                              label: plant.wateringFrequency.loc(context),
                              icon: Icons.opacity),
                          const SizedBox(height: 8),
                          LeafChip(
                              label: plant.fertilizationFrequency.loc(context),
                              icon: Icons.grass),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LeafChip(
                              label: plant.soilType.loc(context),
                              icon: Icons.terrain),
                          const SizedBox(height: 8),
                          LeafChip(
                              label: plant.potSize.loc(context),
                              icon: Icons.category),
                          const SizedBox(height: 8),
                          LeafChip(
                              label: plant.humidityRequirement.loc(context),
                              icon: Icons.grain)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            LeafCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(plant.nickname, style: accentStyle),
                      const SizedBox(height: 8),
                    ],
                  ),
                  CircleAvatar(
                      radius: 80,
                      child: Image.asset("assets/images/logo.png",
                          width: 120, height: 120)),
                  // Image.network(
                  //   'https://via.placeholder.com/200',
                  //   width: 200,
                  //   height: 200,
                  //   fit: BoxFit.cover,
                  // ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        // Wrap Text widget with Expanded to use available horizontal space
                        child: Text(
                          plant.notes ?? '',
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
          ],
        ),
      ),
    );
  }
}
